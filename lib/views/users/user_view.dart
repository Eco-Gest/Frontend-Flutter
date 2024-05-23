import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_state.dart';
import 'package:ecogest_front/widgets/account/subscription_widget.dart';
import 'package:ecogest_front/widgets/account/unsubscription_widget.dart';
import 'package:ecogest_front/widgets/post/posts_userview_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserView extends StatefulWidget {
  UserView({Key? key, required this.userId});

  final int userId;

  static String name = 'users';

  @override
  _UserView createState() => _UserView();
}

class _UserView extends State<UserView> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<UserCubit>().getUser(widget.userId);
      context.read<UsersRelationCubit>().state;
    });
  }

  @override
  Widget build(BuildContext context) {
    int userId = widget.userId;
    return Scaffold(
      appBar: const ThemeAppBar(title: "Profil"),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        scrollDirection: axisDirectionToAxis(AxisDirection.down),
        child: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: refreshData,
          child: Stack(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider<UsersRelationCubit>(
                    create: (_) => UsersRelationCubit(),
                  ),
                  BlocProvider<UserCubit>(
                    create: (_) => UserCubit()..getUser(userId),
                  ),
                ],
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserInitial || state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UserError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is UserSuccess) {
                      return BlocBuilder<UsersRelationCubit,
                          UsersRelationState>(
                        builder: (context, usersRelationState) {
                          final authenticationState =
                              context.read<AuthenticationCubit>().state;
                          UserModel? userAuthenticated =
                              authenticationState.user;

                          bool? isFollowing = state.isFollowing;
                          bool? isFollowed = state.isFollowed;
                          bool? isBlocked = state.isBlocked;

                          bool isFollowingPending = false;
                          if (isFollowing == null) {
                            isFollowingPending = false;
                          } else if (isFollowing == false) {
                            isFollowingPending = true;
                          }

                          bool isFollowedPending = false;
                          if (isFollowed == null) {
                            isFollowedPending = false;
                          } else if (isFollowed == false) {
                            isFollowedPending = true;
                          }

                          if (userAuthenticated!.id != userId) {
                            // user blocked
                            if (isBlocked == true ||
                                usersRelationState is BlockStateSuccess) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26.0),
                                child: Column(
                                  children: [
                                    // Account Info Widget
                                    AccountInfo(
                                      user: state.user!,
                                      isBlocked: isBlocked ?? true,
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                        height: 1.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // TODO
                                    // Bouton débloquer
                                    SizedBox(
                                      width: 300,
                                      child: FilledButton(
                                        style: TextButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          padding: const EdgeInsets.all(20),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<UsersRelationCubit>()
                                              .unblockUser(userId);
                                        },
                                        child: const Text(
                                          style: TextStyle(fontSize: 18),
                                          'Débloquer',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    Container(
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.blueGrey.shade200,
                                    ),
                                    const SizedBox(height: 40),
                                    const Icon(
                                      Icons.lock_outline,
                                      size: 60,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Vous avez bloqué ce compte",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                        "Débloquez ce compte pour voir son contenu"),
                                  ],
                                ),
                              );
                            }
                            if (usersRelationState is UnBlockStateSuccess) {
                              // user private
                              if (state.user!.isPrivate!) {
                                // status pending
                                if (isFollowing == null ||
                                    isFollowing == false) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26.0),
                                    child: Column(
                                      children: [
                                        // Account Info Widget
                                        AccountInfo(
                                          user: state.user!,
                                          isBlocked: isBlocked ?? false,
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        BlocProvider<UsersRelationCubit>(
                                          create: (_) => UsersRelationCubit(),
                                          child: SubscriptionWidget(
                                            userId: state.user!.id!,
                                            isFollowingPending:
                                                isFollowingPending,
                                            isFollowedPending:
                                                isFollowedPending,
                                            onSubscriptionButton: () {
                                              setState(() {
                                                isFollowingPending =
                                                    !isFollowingPending;
                                                isFollowing = !isFollowing!;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 2,
                                          color: Colors.blueGrey.shade200,
                                        ),
                                        const SizedBox(height: 40),
                                        const Icon(
                                          Icons.lock_outline,
                                          size: 60,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Ce compte est privé",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                            "Suivez le compte pour voir son contenu"),
                                      ],
                                    ),
                                  );
                                }

                                if (isFollowed == null || isFollowed == false) {
                                  isFollowed = false;
                                  // status approved
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26.0),
                                    child: Column(
                                      children: [
                                        // Account Info Widget
                                        AccountInfo(
                                          user: state.user!,
                                          isBlocked: isBlocked ?? false,
                                        ),
                                        const SizedBox(height: 20),
                                        BlocProvider<UsersRelationCubit>(
                                          create: (_) => UsersRelationCubit(),
                                          child: UnSubscriptionWidget(
                                            userId: state.user!.id!,
                                            isFollowed: isFollowed,
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        // New Widget: Account Trophies
                                        AccountTrophies(
                                            userId: state.user!.id!),
                                        const SizedBox(height: 20),

                                        PostsUserviewWidget(
                                          userId: state.user!.id!,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }

                              // user public
                              // status pending
                              if (isFollowing == null || isFollowing == false) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: Column(
                                    children: [
                                      // Account Info Widget
                                      AccountInfo(
                                        user: state.user!,
                                        isBlocked: isBlocked ?? false,
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          height: 1.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      BlocProvider<UsersRelationCubit>(
                                        create: (_) => UsersRelationCubit(),
                                        child: SubscriptionWidget(
                                          userId: state.user!.id!,
                                          isFollowingPending:
                                              isFollowingPending,
                                          isFollowedPending: isFollowedPending,
                                          onSubscriptionButton: () {
                                            setState(() {
                                              isFollowingPending =
                                                  !isFollowingPending;
                                              isFollowing = !isFollowing!;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // New Widget: Account Trophies
                                      AccountTrophies(userId: state.user!.id!),
                                      const SizedBox(height: 20),

                                      PostsUserviewWidget(
                                          userId: state.user!.id!),
                                    ],
                                  ),
                                );
                              }

                              // status approved
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26.0),
                                child: Column(
                                  children: [
                                    // Account Info Widget
                                    AccountInfo(
                                      user: state.user!,
                                      isBlocked: isBlocked ?? false,
                                    ),
                                    const SizedBox(height: 20),
                                    BlocProvider<UsersRelationCubit>(
                                      create: (_) => UsersRelationCubit(),
                                      child: UnSubscriptionWidget(
                                        userId: state.user!.id!,
                                        isFollowed: isFollowedPending,
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // New Widget: Account Trophies
                                    AccountTrophies(userId: state.user!.id!),
                                  ],
                                ),
                              );
                            }
                          }

                          // user.id == userAuthenticated.id
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 26.0),
                            child: Column(
                              children: [
                                // Account Info Widget
                                AccountInfo(
                                  user: state.user!,
                                  isBlocked: false,
                                ),
                                const SizedBox(height: 20),
                                // New Widget: Account Trophies
                                AccountTrophies(userId: state.user!.id!),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
