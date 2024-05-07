import 'package:ecogest_front/models/subscription_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

class SubscriptionsListWidget extends StatefulWidget {
  SubscriptionsListWidget(
      {super.key,
      required this.subscriptions,
      required this.isFollowerList,
      required this.userId,
      required this.isFollowing});

  final int userId;
  final List<SubscriptionModel?> subscriptions;

  final bool isFollowerList;
  final bool isFollowing;

  @override
  _SubscriptionsListWidget createState() => _SubscriptionsListWidget();
}

class _SubscriptionsListWidget extends State<SubscriptionsListWidget> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final List<SubscriptionModel?> subscriptions = widget.subscriptions;
    if (subscriptions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Text('Oops rien à voir ici !'),
        ),
      );
    }
    return BlocProvider<SubscriptionCubit>(
      create: (_) => SubscriptionCubit(),
      child: Builder(builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemCount: subscriptions.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < subscriptions.length) {
              if (widget.isFollowerList) {
                return BlocBuilder<SubscriptionCubit, SubscriptionState>(
                    builder: (context, state) {
                  if (context.read<SubscriptionCubit>().state
                      is RemoveFollowerStateSuccess) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (subscriptions[index]?.follower!.image !=
                                  null) ...[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      subscriptions[index]!
                                          .follower!
                                          .image
                                          .toString()),
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
                                      '/users/${subscriptions[index]!.followerId}');
                                },
                                child: Text(
                                  subscriptions[index]
                                          ?.follower
                                          ?.username
                                          ?.toString() ??
                                      'Utilisateur inconnu',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          if (widget.userId ==
                              context
                                  .read<AuthenticationCubit>()
                                  .state
                                  .user!
                                  .id) ...[
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: (context
                                        .read<ThemeSettingsCubit>()
                                        .state
                                        .isDarkMode
                                    ? darkColorScheme.primary
                                    : lightColorScheme.primary),
                                fixedSize: const Size(160, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<SubscriptionCubit>()
                                    .removeFollower(
                                        subscriptions[index]!.followerId!);
                              },
                              child: const Text(
                                'Retirer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ]
                        ]),
                  );
                });
              }
              return BlocBuilder<SubscriptionCubit, SubscriptionState>(
                builder: (context, state) {
                  if (context.read<SubscriptionCubit>().state
                      is SubscriptionStateSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (subscriptions[index]?.following!.image !=
                                    null) ...[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        subscriptions[index]!
                                            .following!
                                            .image
                                            .toString()),
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
                                        '/users/${subscriptions[index]!.followingId}');
                                  },
                                  child: Text(
                                    subscriptions[index]
                                            ?.following
                                            ?.username
                                            ?.toString() ??
                                        'Utilisateur inconnu',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.userId ==
                                context
                                    .read<AuthenticationCubit>()
                                    .state
                                    .user!
                                    .id) ...[
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: (Colors.white),
                                  fixedSize: const Size(160, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<SubscriptionCubit>()
                                      .subscription(
                                          subscriptions[index]!.followingId!,
                                          true);
                                },
                                child: const Text(
                                  'Annuler',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ]
                          ]),
                    );
                  }
                  if (context.read<SubscriptionCubit>().state
                      is UnSubscriptionStateSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (subscriptions[index]?.following!.image !=
                                    null) ...[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        subscriptions[index]!
                                            .following!
                                            .image
                                            .toString()),
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
                                        '/users/${subscriptions[index]!.followingId}');
                                  },
                                  child: Text(
                                    subscriptions[index]
                                            ?.following
                                            ?.username
                                            ?.toString() ??
                                        'Utilisateur inconnu',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.userId ==
                                context
                                    .read<AuthenticationCubit>()
                                    .state
                                    .user!
                                    .id) ...[
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: (context
                                          .read<ThemeSettingsCubit>()
                                          .state
                                          .isDarkMode
                                      ? darkColorScheme.primary
                                      : lightColorScheme.primary),
                                  fixedSize: const Size(160, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<SubscriptionCubit>()
                                      .subscription(
                                          subscriptions[index]!.followingId!,
                                          false);
                                },
                                child: const Text(
                                  'Me réabonner',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]
                          ]),
                    );
                  }
                  if (context.read<SubscriptionCubit>().state
                      is SubscriptionCancelStateSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (subscriptions[index]?.following!.image !=
                                    null) ...[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        subscriptions[index]!
                                            .following!
                                            .image
                                            .toString()),
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
                                        '/users/${subscriptions[index]!.followingId}');
                                  },
                                  child: Text(
                                    subscriptions[index]
                                            ?.following
                                            ?.username
                                            ?.toString() ??
                                        'Utilisateur inconnu',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.userId ==
                                context
                                    .read<AuthenticationCubit>()
                                    .state
                                    .user!
                                    .id) ...[
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: (context
                                          .read<ThemeSettingsCubit>()
                                          .state
                                          .isDarkMode
                                      ? darkColorScheme.primary
                                      : lightColorScheme.primary),
                                  fixedSize: const Size(160, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<SubscriptionCubit>()
                                      .subscription(
                                          subscriptions[index]!.followingId!,
                                          false);
                                },
                                child: const Text(
                                  'M\'abonner',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]
                          ]),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (subscriptions[index]?.following!.image !=
                                  null) ...[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      subscriptions[index]!
                                          .following!
                                          .image
                                          .toString()),
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
                                      '/users/${subscriptions[index]!.followingId}');
                                },
                                child: Text(
                                  subscriptions[index]
                                          ?.following
                                          ?.username
                                          ?.toString() ??
                                      'Utilisateur inconnu',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          if (widget.userId ==
                              context
                                  .read<AuthenticationCubit>()
                                  .state
                                  .user!
                                  .id) ...[
                         FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: (Colors.white),
                                  fixedSize: const Size(160, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<SubscriptionCubit>()
                                      .unSubscribe(
                                          subscriptions[index]!.followingId!
                                      );
                                },
                                child: const Text(
                                  'Me désabonner',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                          ]
                        ]),
                  );
                },
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text('Oops rien à voir ici !'),
              ),
            );
          },
          // Listen to scroll events in the goal to load more posts
        );
      }),
    );
  }
}
