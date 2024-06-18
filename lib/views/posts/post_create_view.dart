import 'package:date_field/date_field.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/services/tag_service.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class PostCreateView extends StatefulWidget {
  const PostCreateView({Key? key}) : super(key: key);
  static String name = 'post-create';

  @override
  _PostCreateView createState() => _PostCreateView();
}

class _PostCreateView extends State<PostCreateView> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final positionController = TextEditingController();
  final tagController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  late List<TagModel> _tagsToSave = [];

  final List<bool> _selectedPostType = <bool>[true, false];

  bool datesValidation() {
    if (startDate != null && endDate != null) {
      if (startDate!.isBefore(endDate!)) {
        return true;
      }
    }
    return false;
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(
        title: 'Créer un post ',
      ),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider(
              create: (context) => PostFormCubit()..getDefaults(),
              child: Builder(builder: (context) {
                return BlocListener<PostFormCubit, PostFormState>(
                  listener: (context, state) {
                    if (state is PostFormStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Erreur lors de la publication.')),
                      );
                      context.read<PostFormCubit>().getDefaults();
                    }
                    if (state is PostFormStateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Publication réussie')),
                      );
                      GoRouter.of(context).goNamed(HomeView.name);
                    }
                  },
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        BlocBuilder<PostFormCubit, PostFormState>(
                            builder: (context, state) {
                          if (state is SelectionState) {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child:
                                  // Type
                                  ToggleButtons(
                                constraints: BoxConstraints(
                                    minWidth:
                                        (MediaQuery.of(context).size.width -
                                                26) /
                                            2,
                                    minHeight: 50.0),
                                onPressed: (int index) {
                                  for (int i = 0;
                                      i < _selectedPostType.length;
                                      i++) {
                                    _selectedPostType[i] = i == index;
                                    context
                                        .read<PostFormCubit>()
                                        .selectPostType(
                                            state.selectableTypes[index]);
                                  }
                                },
                                isSelected: _selectedPostType,
                                children: <Widget>[
                                  Text(state.selectableTypes[0].displayName),
                                  Text(state.selectableTypes[1].displayName),
                                ],
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                        // Category
                        BlocBuilder<PostFormCubit, PostFormState>(
                            builder: (context, state) {
                          if (state is SelectionState) {
                            return Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                value: state.selectedCategory,
                                items: state.selectableCategories
                                    .map<DropdownMenuItem<int>>((category) {
                                  return DropdownMenuItem<int>(
                                      value: category.id,
                                      child:
                                          Text(category.title ?? 'Category'));
                                }).toList(),
                                onChanged: (value) {
                                  context
                                      .read<PostFormCubit>()
                                      .selectCategory(value as int);
                                },
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Titre',
                              hintText: 'Entrez un titre',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => (value != null &&
                                    value.isNotEmpty &&
                                    value.length >= 0)
                                ? null
                                : 'Titrer non valide',
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            textAlign: TextAlign.justify,
                            controller: descriptionController,
                            autofocus: false,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                              hintText: 'Entrez une description',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: positionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Position',
                              hintText: 'Entrez votre géolocalisation',
                            ),
                          ),
                        ),

                        BlocBuilder<PostFormCubit, PostFormState>(
                            builder: (context, state) {
                          if (state is SelectionState &&
                              state.selectedType == PostType.challenge) {
                            startDate = DateTime.now();
                            endDate = startDate!.add(const Duration(days: 1));
                            return Column(children: [
                              // date debut
                              Container(
                                padding: const EdgeInsets.all(10),
                                constraints: BoxConstraints(
                                  minWidth:
                                      (MediaQuery.of(context).size.width - 36),
                                ),
                                child: DateTimeFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) => datesValidation()
                                      ? null
                                      : "Dates non valides. Veuillez sélectionner une date de début et de fin.",
                                  initialValue: startDate,
                                  initialPickerDateTime: startDate,
                                  mode: DateTimeFieldPickerMode.date,
                                  dateFormat: DateFormat.yMMMd('fr_FR'),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black45),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.event_note),
                                    labelText: 'Date',
                                  ),
                                  onChanged: (value) {
                                    startDate = value;
                                  },
                                ),
                              ),
                              // date fin
                              Container(
                                padding: const EdgeInsets.all(10),
                                constraints: BoxConstraints(
                                  minWidth:
                                      (MediaQuery.of(context).size.width - 36),
                                ),
                                child: DateTimeFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) => datesValidation()
                                      ? null
                                      : 'Dates non valides. La date de fin doit être au moins un jour après la date de début.',
                                  initialValue: endDate,
                                  initialPickerDateTime: endDate,
                                  mode: DateTimeFieldPickerMode.date,
                                  dateFormat: DateFormat.yMMMd('fr_FR'),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black45),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.event_note),
                                    labelText: 'Date',
                                  ),
                                  onChanged: (value) {
                                    endDate = value;
                                  },
                                ),
                              ),
                            ]);
                          }
                          return const SizedBox();
                        }),

                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10),
                          child: FlutterTagging<TagModel>(
                              initialItems: _tagsToSave,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: const InputDecoration(
                                  hintText: 'Saisir un nouveau tag',
                                  labelText: 'Ajouter un ou plusieurs tags',
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                  FilteringTextInputFormatter.deny(' '),
                                ],
                              ),
                              findSuggestions: TagService.getTagModels,
                              additionCallback: (value) {
                                return TagModel(
                                  label: value,
                                );
                              },
                              onAdded: (tag) {
                                // api calls here, triggered when add to tag button is pressed
                                return tag;
                              },
                              configureSuggestion: (tag) {
                                return SuggestionConfiguration(
                                  title: Text(tag.label),
                                  additionWidget: const Chip(
                                    avatar: Icon(
                                      Icons.add_circle,
                                    ),
                                    label: Text('Ajouter un nouveau tag'),
                                    labelStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                );
                              },
                              configureChip: (tag) {
                                return ChipConfiguration(
                                  label: Text(tag.label),
                                  backgroundColor: lightColorScheme.primary,
                                  labelStyle: const TextStyle(color: Colors.white),
                                  deleteIconColor: Colors.white,
                                );
                              },
                              onChanged: () {
                                _tagsToSave
                                    .map<TagModel>((tag) => tag)
                                    .toList();
                              }),
                        ), // tags
                        // image
                        Column(
                          children: [
                            const Text('Sélectionnez une image'),
                            OutlinedButton(
                              onPressed: getImage,
                              child: _buildImage(),
                            ),
                          ],
                        ),
                        // level
                        BlocBuilder<PostFormCubit, PostFormState>(
                            builder: (context, state) {
                          if (state is SelectionState) {
                            return Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                value: state.selectedLevel,
                                items: state.selectableLevels
                                    .map<DropdownMenuItem<PostLevel>>((level) {
                                  return DropdownMenuItem<PostLevel>(
                                      value: level,
                                      child: Text(level.displayName));
                                }).toList(),
                                onChanged: (value) {
                                  context
                                      .read<PostFormCubit>()
                                      .selectPostLevel(value as PostLevel);
                                },
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width - 26) / 2,
                            height: 50.0,
                            child: FilledButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Publication en cours...')),
                                  );
                                  context.read<PostFormCubit>().createPost(
                                        title: titleController.text,
                                        description: descriptionController.text,
                                        position: positionController.text,
                                        startDate: startDate,
                                        endDate: endDate,
                                        tags: _tagsToSave,
                                        image: _image?.path,
                                      );
                                }
                              },
                              child: const Text('Publier'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }
}
