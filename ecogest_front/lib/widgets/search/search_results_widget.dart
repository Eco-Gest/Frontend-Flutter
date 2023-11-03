import 'package:ecogest_front/views/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/search/search_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/views/post_detail_view.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchStateInitial) {
          return const SizedBox.shrink();
        } else if (state is SearchStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchStateError) {
          return Center(child: Text(state.message));
        } else if (state is SearchStateSuccess) {
          return Column(children: [
            Text(state.posts.isEmpty
                ? 'Pas de publication'
                : 'Résultats des publications'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.posts.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.posts.elementAt(index)?.image == null
                      ? null
                      : NetworkImage(state.posts.elementAt(index)!.image!),
                ),
                title: Text(state.posts.elementAt(index)?.title ?? 'Titre'),
                onTap: () {
                  context.pushNamed(PostDetailView.name, pathParameters: {
                    'id': state.posts.elementAt(index)!.id.toString(),
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(state.users.isEmpty
                ? 'Pas d\'utilisateurs'
                : 'Résultats des utilisateurs'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.users.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.users.elementAt(index)?.image == null
                      ? const AssetImage('assets/profile.jpg') as ImageProvider
                      : NetworkImage(state.users.elementAt(index)!.image!),
                ),
                title:
                    Text(state.users.elementAt(index)?.username ?? 'Username'),
                onTap: () {
                  context.pushNamed(UserView.name, pathParameters: {
                    'id': state.users.elementAt(index)!.id.toString(),
                  });
                },
              ),
            ),
          ]);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
