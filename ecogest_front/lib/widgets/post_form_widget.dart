import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/post/form_post_cubit.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostFormWidget extends StatelessWidget {
  PostFormWidget({super.key});
  // bool? isChallenge;
  // DateTime? startDate;
  // DateTime? endDate;

  static String name = 'postCreate';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final positionController = TextEditingController();
  final tagController = TextEditingController();
  final List<String> tags = List.empty();
  final formKey = GlobalKey<FormState>();

  void addTag(String newTag) {
    tags.add(newTag);
  }

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final user = authenticationState.user;
      return Scaffold(
        appBar: const ThemeAppBar(title: 'Publier'),
        body: BlocProvider(
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
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Publication réussie')),
                  // );
                  // GoRouter.of(context).goNamed(
                  //   PostDetailView.name,
                  //   pathParameters: {'id': state.post.id.toString()},
                  // );
                }
              },
              child: Form(
                key: formKey,
                child: Column(
                  children: [
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
                                    (MediaQuery.of(context).size.width - 36) /
                                        2,
                                minHeight: 50.0),
                            isSelected: const <bool>[true, false],
                            children: <Widget>[
                              Text(state.selectableTypes[0].name),
                              Text(state.selectableTypes[1].name),
                            ],
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    }),

                    // TODO
                    // Bloc provider et bloc builder pour recuperer les categories
                    // DropdownCategory(),
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
                        validator: (value) =>
                            (value == null) ? null : 'Veuillez entrer un titre',
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.topCenter,
                    //   padding: const EdgeInsets.all(10),
                    //   height: 20,
                    //   child: TextFormField(
                    //     controller: descriptionController,
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Description',
                    //       hintText: 'Entrez une description',
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.topCenter,
                    //   padding: const EdgeInsets.all(10),
                    //   child: TextFormField(
                    //     controller: positionController,
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Position',
                    //       hintText: 'Entrez votre géolocalisation',
                    //     ),
                    //   ),
                    // ),

                    // date debut
                    // DateWidget(),
                    // // date fin
                    // DateWidget(),

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
                    // DropdownLevel(),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Processing transfer')),
                            );
                            context.read<PostFormCubit>().createPost(
                                  authorId: user!.id.toString(),
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  startDate: titleController.text,
                                  endDate: titleController.text,
                                  tag: '{' + tags.toString() + '}',
                                );
                          }
                        },
                        child: const Text('Publier'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: const AppBarFooter(),
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

class TogglePostType extends StatefulWidget {
  TogglePostType({super.key, this.value});
  String? value;

  @override
  State<TogglePostType> createState() => _TogglePostTypeState();
}

class _TogglePostTypeState extends State<TogglePostType> {
  final List<bool> _selectedPostType = <bool>[true, false];

  static const List<Widget> postType = <Widget>[Text('Geste'), Text('Défi')];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child:
          // Type
          ToggleButtons(
        onPressed: (int index) {
          setState(() {
            // The button that is tapped is set to true, and the others to false.
            for (int i = 0; i < _selectedPostType.length; i++) {
              _selectedPostType[i] = i == index;
              widget.value = _selectedPostType[index].toString();
            }
          });
        },
        constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width - 36) / 2,
            minHeight: 50.0),
        isSelected: _selectedPostType,
        children: postType,
      ),
    );
  }
}

class DropdownCategory extends StatelessWidget {
  DropdownCategory({super.key});

  String? category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Language'),
          DropdownButton(
            value: 'Mobilité',
            items: const [
              DropdownMenuItem(
                value: 'Mobilité',
                child: Text('Mobilité'),
              ),
              DropdownMenuItem(
                value: 'Alimentation',
                child: Text('Alimentation'),
              ),
              DropdownMenuItem(
                value: 'Déchets',
                child: Text('Déchets'),
              ),
              DropdownMenuItem(
                value: 'Biodiversité',
                child: Text('Biodiversité'),
              ),
              DropdownMenuItem(
                value: 'Energie',
                child: Text('Energie'),
              ),
              DropdownMenuItem(
                value: 'Do It Yourself',
                child: Text('Do It Yourself'),
              ),
              DropdownMenuItem(
                value: 'Technologies',
                child: Text('Technologies'),
              ),
              DropdownMenuItem(
                value: 'Seconde vie',
                child: Text('Seconde vie'),
              ),
              DropdownMenuItem(
                value: 'Divers',
                child: Text('Divers'),
              ),
            ],
            onChanged: (value) {
              category = value;
            },
          ),
        ],
      ),
    );
  }
}

class DropdownLevel extends StatelessWidget {
  DropdownLevel({super.key});

  String? level;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Level'),
          DropdownButton(
            value: 'easy',
            items: const [
              DropdownMenuItem(
                value: 'easy',
                child: Text('Facile'),
              ),
              DropdownMenuItem(
                value: 'medium',
                child: Text('Moyen'),
              ),
              DropdownMenuItem(
                value: 'hard',
                child: Text('Difficile'),
              ),
            ],
            onChanged: (value) {
              level = value;
            },
          ),
        ],
      ),
    );
  }
}
