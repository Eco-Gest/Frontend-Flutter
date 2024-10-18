import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/services/tag_service.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class PostFormWidget extends StatefulWidget {
  PostFormWidget({Key? key, this.prefilledPost}) : super(key: key);

  PostModel? prefilledPost;

  @override
  _PostFormWidget createState() => _PostFormWidget();
}

class _PostFormWidget extends State<PostFormWidget> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final positionController = TextEditingController();
  final tagController = TextEditingController();

  late final List<TagModel> _tagsToSave = [];

  late List<bool> _selectedPostType;

  DateTime? startDate;
  DateTime? endDate;

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
    if (pickedFile != null) {      
      _image = await compressImage(File(pickedFile.path));
      setState(() {});
    }
  }

  Future<File> compressImage(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 800);
      Uint8List compressedImage = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp_image.jpg');
      await tempFile.writeAsBytes(compressedImage);

      return tempFile;
    } else {
      throw Exception('Error processing the image');
    }
  }

  @override
  Widget build(BuildContext context) {
    PostModel? prefilledPost = widget.prefilledPost;

    titleController.text = prefilledPost?.title ?? '';
    descriptionController.text = prefilledPost?.description ?? '';
    positionController.text = prefilledPost?.position ?? '';
    startDate = prefilledPost?.startDate == null
        ? null
        : DateTime.parse(prefilledPost!.startDate!);
    endDate = prefilledPost?.endDate == null
        ? null
        : DateTime.parse(prefilledPost!.endDate!);
    if (prefilledPost!.type == "action") {
      _selectedPostType = [true, false];
    } else {
      _selectedPostType = [false, true];
    }
    _tagsToSave.addAll(prefilledPost.tags!);
    return BlocProvider(
      create: (context) => PostFormCubit()
        ..getValuesEdit(
            PostType.fromValue(prefilledPost.type!),
            prefilledPost.categoryId!,
            PostLevel.fromValue(prefilledPost.level!)),
      child: Builder(builder: (context) {
        return BlocListener<PostFormCubit, PostFormState>(
          listener: (context, state) {
            if (state is PostFormStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              context.read<PostFormCubit>().getValuesEdit(
                  PostType.fromValue(prefilledPost.type!),
                  prefilledPost.categoryId!,
                  PostLevel.fromValue(prefilledPost.level!));
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
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              minHeight: 50.0),
                          onPressed: (int index) {
                            for (int i = 0; i < _selectedPostType.length; i++) {
                              _selectedPostType[i] = i == index;
                              context
                                  .read<PostFormCubit>()
                                  .selectPostType(state.selectableTypes[index]);
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
                      textCapitalization: TextCapitalization.sentences,
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Titre',
                        hintText: 'Entrez un titre',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (value != null &&
                              value.isNotEmpty &&
                              // ignore: prefer_is_empty
                              value.length >= 0)
                          ? null
                          : 'Titrer non valide',
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.justify,
                      controller: descriptionController,
                      autofocus: false,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
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
                      textCapitalization: TextCapitalization.sentences,
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
                    startDate = startDate ?? DateTime.now();
                    endDate =
                        endDate ?? startDate!.add(const Duration(days: 1));
                    if (state is SelectionState &&
                        state.selectedType == PostType.challenge) {
                      return Column(children: [
                        // date debut
                        Container(
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            minWidth: (MediaQuery.of(context).size.width - 36),
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
                              errorStyle: TextStyle(color: Colors.redAccent),
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
                            minWidth: (MediaQuery.of(context).size.width - 36),
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
                              errorStyle: TextStyle(color: Colors.redAccent),
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
                            additionWidget: Chip(
                              avatar: const Icon(
                                Icons.add_circle,
                              ),
                              backgroundColor: context
                                      .read<ThemeSettingsCubit>()
                                      .state
                                      .isDarkMode
                                  ? darkColorScheme.primary
                                  : lightColorScheme.primary,
                              label: const Text('Ajouter un nouveau tag'),
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                color: context
                                        .read<ThemeSettingsCubit>()
                                        .state
                                        .isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        },
                        configureChip: (tag) {
                          return ChipConfiguration(
                            label: Text(tag.label),
                            backgroundColor: context
                                    .read<ThemeSettingsCubit>()
                                    .state
                                    .isDarkMode
                                ? darkColorScheme.primary
                                : lightColorScheme.primary,
                            labelStyle: const TextStyle(color: Colors.white),
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
                      GestureDetector(
                        onTap: getImage,
                        child: _buildImage(prefilledPost.image),
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
                    padding: const EdgeInsets.all(15.0),
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
                                  postId: prefilledPost.id,
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
  }

  Widget _buildImage(String? postImageUrl) {
    if (_image == null && postImageUrl == null) {
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: _image != null
                    ? (kIsWeb
                        ? NetworkImage(_image!.path) as ImageProvider<Object>
                        : FileImage(_image!))
                    : NetworkImage(postImageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(
            Icons.add,
            color: Colors.grey.withOpacity(0.6),
            size: 40,
          ),
        ],
      );
    }
  }
}
