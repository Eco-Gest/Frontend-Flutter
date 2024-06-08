import 'package:ecogest_front/models/users_relation_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_state.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

class SubscriptionsListWidget extends StatefulWidget {
  const SubscriptionsListWidget({
    super.key,
    required this.subscriptions,
    required this.isFollowerList,
    required this.userId,
    required this.isFollowing,
  });

  final int userId;
  final List<UsersRelationModel?> subscriptions;
  final bool isFollowerList;
  final bool isFollowing;

  @override
  _SubscriptionsListWidget createState() => _SubscriptionsListWidget();
}

class _SubscriptionsListWidget extends State<SubscriptionsListWidget> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersRelationCubit>(
      create: (_) => UsersRelationCubit(),
      child: BlocConsumer<UsersRelationCubit, UsersRelationState>(
        listener: (context, state) {
          if (state is RemoveFollowerStateSuccess) {
            setState(() {
              widget.subscriptions.removeWhere((subscription) =>
                  widget.isFollowerList && subscription?.followerId == state.followerId);
            });
          }
          if (state is UnSubscriptionStateSuccess) {
            setState(() {
              widget.subscriptions.removeWhere((subscription) =>
                  !widget.isFollowerList && subscription?.followingId == state.followingId);
            });
          }
        },
        builder: (context, state) {
          final List<UsersRelationModel?> subscriptions = widget.subscriptions;

          if (subscriptions.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text('Oops rien à voir ici !'),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: subscriptions.length,
            itemBuilder: (BuildContext context, int index) {
              return SubscriptionItem(
                subscription: subscriptions[index],
                isFollowerList: widget.isFollowerList,
                userId: widget.userId,
              );
            },
          );
        },
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({
    Key? key,
    required this.subscription,
    required this.isFollowerList,
    required this.userId,
  }) : super(key: key);

  final UsersRelationModel? subscription;
  final bool isFollowerList;
  final int userId;

  @override
  Widget build(BuildContext context) {
    if (subscription == null) return SizedBox.shrink();

    final themeCubit = context.read<ThemeSettingsCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    final isCurrentUser = userId == authCubit.state.user?.id;
    final primaryColor = themeCubit.state.isDarkMode
        ? darkColorScheme.primary
        : lightColorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (subscriptionImage() != null) ...[
                CircleAvatar(
                  backgroundImage: NetworkImage(subscriptionImage()!),
                )
              ] else ...[
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ],
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(
                      '/users/${isFollowerList ? subscription!.followerId : subscription!.followingId}');
                },
                child: Text(
                  subscriptionUsername(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          if (isCurrentUser)
            actionButton(context, primaryColor),
        ],
      ),
    );
  }

  String? subscriptionImage() {
    final imageUrl = isFollowerList
        ? subscription?.follower?.image
        : subscription?.following?.image;

    return imageUrl?.toString();
  }

  String subscriptionUsername() {
    final username = isFollowerList
        ? subscription?.follower?.username
        : subscription?.following?.username;

    return username ?? 'Utilisateur inconnu';
  }

  Widget actionButton(BuildContext context, Color primaryColor) {
    final buttonText = isFollowerList ? 'Retirer' : 'Me désabonner';
    final buttonColor = primaryColor;
    final textColor = Colors.white;

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: const Size(160, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        if (isFollowerList) {
          context.read<UsersRelationCubit>().removeFollower(subscription!.followerId!);
        } else {
          context.read<UsersRelationCubit>().unSubscribe(subscription!.followingId!);
        }
      },
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
