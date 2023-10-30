import 'package:ecogest_front/state_management/search/search_cubit.dart';
import 'package:ecogest_front/widgets/search/search_results_widget.dart';
import 'package:ecogest_front/widgets/search/search_bar_widget.dart';
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<SearchCubit>(
              create: (_) => SearchCubit(),
              child: Column(
                children: 
                [
                  SearchBarWidget(),
                  SearchResultsWidget(),
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}
