import 'package:ecogest_front/state_management/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  static String name = 'search';

  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: queryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Rechercher un post',
              hintText: 'Rechercher un post',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => (value != null && value.length > 0)
                ? null
                : 'Recherche non valide',
          ),
        ),
        ElevatedButton(
          child: const Text(
            'Rechercher',
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(400, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            context.read<SearchCubit>().getSearchResults(queryController.text);
          },
        ),
      ],
    );
  }
}
