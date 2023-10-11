import 'package:date_field/date_field.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:go_router/go_router.dart';

class PostCreateView extends StatelessWidget {
  PostCreateView({super.key});

  static String name = 'post-create';

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final positionController = TextEditingController();
  final tagController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  final List<bool> _selectedPostType = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final UserModel? user = authenticationState.user;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Créer un post '),
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
                        GoRouter.of(context).goNamed(
                          HomeView.name,
                        );
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
                              return Column(children: [
                                // date debut
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                    minWidth:
                                        (MediaQuery.of(context).size.width -
                                            36),
                                  ),
                                  child: DateTimeFormField(
                                    initialValue: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    mode: DateTimeFieldPickerMode.date,
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
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
                                        (MediaQuery.of(context).size.width -
                                            36),
                                  ),
                                  child: DateTimeFormField(
                                    initialValue: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    mode: DateTimeFieldPickerMode.date,
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
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

                          // tags
                          Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: tagController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tags',
                                hintText: 'Entrez un ou plusieurs tags',
                              ),
                            ),
                          ),
                          // Todo
                          // résultats des tags ajoutés : tags
                          // pouvoir les supprimer (idealement)

                          // Todo
                          // image

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
                                      .map<DropdownMenuItem<PostLevel>>(
                                          (level) {
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
                              width:
                                  (MediaQuery.of(context).size.width - 26) / 2,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Publication en cours...')),
                                    );
                                    context.read<PostFormCubit>().createPost(
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                          position: positionController.text,
                                          startDate: startDate,
                                          endDate: endDate,
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
    } else {
      // Handle the case where the state is not AuthenticationAuthenticated
      return const Scaffold(
        body: Center(
          child: Text('Problème : utilisateur non authentifié'),
        ),
      );
    }
  }
}
