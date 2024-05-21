import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/tag_service.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PostFormWidget extends StatefulWidget {
  PostFormWidget({Key? key, this.prefilledPost}) : super(key: key);

  PostModel? prefilledPost;

  @override
  _PostFormWidget createState() => _PostFormWidget();
}

class _PostFormWidget extends State<PostFormWidget> {
  final formKey = GlobalKey<FormState>();

  static String name = 'post-create';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final positionController = TextEditingController();
  final tagController = TextEditingController();
  final imageController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  String _selectedTagsJson = 'Nothing to show';
  late List<TagModel> _tagsToSave = [];

  late List<bool> _selectedPostType;

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
    PostModel? prefilledPost = widget.prefilledPost;

    titleController.text = prefilledPost?.title ?? '';
    descriptionController.text = prefilledPost?.description ?? '';
    positionController.text = prefilledPost?.position ?? '';
    imageController.text = prefilledPost?.image ?? '';
    if (prefilledPost!.type == "action") {
      _selectedPostType = [true, false];
    } else {
      _selectedPostType = [false, true];
    }
    _tagsToSave.addAll(prefilledPost!.tags!);
    final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final UserModel? user = authenticationState.user;
      return BlocProvider(
        create: (context) => PostFormCubit()
          ..getValuesEdit(
              PostType.fromValue(prefilledPost!.type!),
              prefilledPost!.categoryId!,
              PostLevel.fromValue(prefilledPost!.level!)),
        child: Builder(builder: (context) {
          return BlocListener<PostFormCubit, PostFormState>(
            listener: (context, state) {
              if (state is PostFormStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Erreur lors de la publication.')),
                );
                context.read<PostFormCubit>().getValuesEdit(
                    PostType.fromValue(prefilledPost!.type!),
                    prefilledPost!.categoryId!,
                    PostLevel.fromValue(prefilledPost!.level!));
              }
              if (state is PostFormStateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Publication réussie')),
                );
                GoRouter.of(context).goNamed(
                  HomeView.name,
                );
              }
            },
            child: SingleChildScrollView(
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
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                                minHeight: 50.0),
                            onPressed: (int index) {
                              for (int i = 0;
                                  i < _selectedPostType.length;
                                  i++) {
                                _selectedPostType[i] = i == index;
                                context.read<PostFormCubit>().selectPostType(
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
                                  child: Text(category.title ?? 'Category'));
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      startDate = DateTime.now();
                      endDate = startDate!.add(const Duration(days: 1));
                      if (state is SelectionState &&
                          state.selectedType == PostType.challenge) {
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
                              initialDate: startDate,
                              mode: DateTimeFieldPickerMode.date,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Date',
                              ),
                              onDateSelected: (value) {
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
                              initialDate: endDate,
                              mode: DateTimeFieldPickerMode.date,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Date',
                              ),
                              onDateSelected: (value) {
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
                            decoration: InputDecoration(
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
                              labelStyle: TextStyle(color: Colors.white),
                              deleteIconColor: Colors.white,
                            );
                          },
                          onChanged: () {
                            _tagsToSave.map<TagModel>((tag) => tag).toList();
                          }),
                    ),

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
                                  value: level, child: Text(level.displayName));
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
                                    content: Text('Publication en cours...')),
                              );
                              context.read<PostFormCubit>().updatePost(
                                    postId: prefilledPost?.id,
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
                          child: const Text('Mettre à jour'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    } else {
      // Handle the case where the state is not AuthenticationAuthenticated
      return const Scaffold(
        body: Center(
          child: Text('Problème : utilisateur non authentifié'),
        ),
      );
    }
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