import 'package:flutter/material.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostEditView extends StatelessWidget {
  static String name = 'post-edit';
  final int postId;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  PostEditView({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        title: 'Modifier le post',
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocBuilder<PostFormCubit, PostFormState>(
              builder: (context, state) {
                if (state is SelectionState) {
                  // Fetch post details based on postId from the state
                  final post = state.post;
                  // Update your text controllers with post details
                  titleController.text = post.title;
                  descriptionController.text = post.description;
                  positionController.text = post.position;
                  // Update other controllers as needed

                  return Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        // Your existing form fields here...

                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width - 26) / 2,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enregistrement en cours...'),
                                    ),
                                  );

                                  // Call the method to update the post
                                  context.read<PostFormCubit>().updatePost(
                                    postId: postId,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    position: positionController.text,
                                    startDate: startDate,
                                    endDate: endDate,
                                    image: imageController.text,
                                  );
                                }
                              },
                              child: const Text('Enregistrer les modifications'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
