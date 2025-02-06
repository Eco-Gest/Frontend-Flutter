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
  String? activeFilter;

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

 Future<void> _updateFilter(PostsFilter filter) async {
    setState(() {
      activeFilter = null; 
    });

    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      activeFilter = filter.name; 
    });
  }

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
                    if (selected) {   
                        _updateFilter(filter);
                    } else {
                      setState(() {
                        activeFilter = null; 
                      });
                    }
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
