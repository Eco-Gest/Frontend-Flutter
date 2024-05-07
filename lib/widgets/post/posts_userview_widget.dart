import 'package:ecogest_front/widgets/challenge_widget.dart';
import 'package:flutter/material.dart';

enum PostsFilter { inProgress, completed, next, actions }

class PostsUserviewWidget extends StatefulWidget {
  const PostsUserviewWidget({super.key, required this.userId});
  final int userId;

  @override
  _PostsUserviewWidget createState() => _PostsUserviewWidget();
}

class _PostsUserviewWidget extends State<PostsUserviewWidget>
    with SingleTickerProviderStateMixin {
  Set<PostsFilter> filters = <PostsFilter>{};
  String? activeFilter;
  List<String> historyFilters = <String>[];

  setTitle(postFilterName) {
    switch (postFilterName) {
      case 'inProgress':
        return 'En cours';
      case 'completed':
        return 'Réalisés';
      case 'next':
        return 'À venir';
      case 'actions':
        return 'Gestes';
      default:
        return 'En cours';
    }
  }

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final int userId = widget.userId;

    return SingleChildScrollView(
      scrollDirection: axisDirectionToAxis(AxisDirection.down),
      child: Column(
        children: [
          Wrap(
            spacing: 5.0,
            children: PostsFilter.values.map((PostsFilter filter) {
              return ChoiceChip(
                label: Text(setTitle(filter.name)),
                selected: filter.name == activeFilter,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      activeFilter = filter.name;
                    } else {
                      activeFilter = null;
                    }
                  });
                },
              );
            }).toList(),
          ),
          activeFilter == null
              ? const SizedBox.shrink()
              : ChallengesWidget(userId: userId, keywordRoute: activeFilter!),
        ],
      ),
    );
  }
}
