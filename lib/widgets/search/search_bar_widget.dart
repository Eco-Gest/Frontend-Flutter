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
              labelText: 'Rechercher une publication ou un utilisateur',
              hintText: 'Rechercher une publication ou un utilisateur',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
             validator: (value) => (value != null && value.isNotEmpty)
                ? null
                : 'Recherche non valide',
          ),
        ),
        SizedBox(
          width: 300,
          child: FilledButton(
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              if (queryController.text.isNotEmpty) {
                context
                    .read<SearchCubit>()
                    .getSearchResults(queryController.text);
              }
            },
            child: const Text("Rechercher"),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
