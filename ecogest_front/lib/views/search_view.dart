import 'package:ecogest_front/state_management/search/search_cubit.dart';
import 'package:ecogest_front/state_management/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  static String name = 'search';

  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Rechercher'),
        bottomNavigationBar: AppBarFooter(),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: queryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value != null && value.length > 0)
                    ? null
                    : 'Recherche non valide',
              ),
            ),
            BlocProvider<SearchCubit>(
              create: (context) {
                final cubit = SearchCubit();
                cubit.getSearchResults(queryController.text);
                return cubit;
              },
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateInitial ||
                      state is SearchStateLoading) {
                    debugPrint('Chargement');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchStateError) {
                    debugPrint('Erreur');
                    return Center(child: Text(state.message));
                  } else if (state is SearchStateSuccess) {
                    debugPrint('Success');
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: state.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(state.results[index][0] ?? ""),
                                  Text(state.results[index][1] ?? ""),
                                ],
                              ),
                            ));
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ));
  }
}
