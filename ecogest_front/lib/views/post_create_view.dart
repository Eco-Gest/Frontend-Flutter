import 'package:ecogest_front/widgets/post_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';

class PostCreateView extends StatelessWidget {
  PostCreateView({super.key});

  static String name = 'post-create';

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter'),
      ),
      bottomNavigationBar: AppBarFooter(),
      body: Column(
        children: [
          PostFormWidget(),
        ],
      ),
    );
  }
}
