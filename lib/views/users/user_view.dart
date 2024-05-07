import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    int userId = widget.userId;
    return Scaffold(
      appBar: const ThemeAppBar(title: "Profil"),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        scrollDirection: axisDirectionToAxis(AxisDirection.down),
        child: Stack(
          children: [
            BlocProvider<UserCubit>(
              create: (context) {
                final cubit = UserCubit();
                cubit.getUser(userId);
                return cubit;
              },
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
                    final authenticationState =
                        context.read<AuthenticationCubit>().state;
                    UserModel? userAuthenticated = authenticationState.user;

                    bool? isFollowing = state.isFollowing;
                    bool? isFollowed = state.isFollowed;

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
                      // user private
                      if (state.user!.isPrivate!) {
                        // status pending
                        if (isFollowing == null || isFollowing == false) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 26.0),
                            child: Column(
                              children: [
                                // Account Info Widget
                                AccountInfo(user: state.user!),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    height: 1.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                BlocProvider<SubscriptionCubit>(
                                  create: (_) => SubscriptionCubit(),
                                  child: SubscriptionWidget(
                                    userId: state.user!.id!,
                                    isFollowingPending: isFollowingPending,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 26.0),
                            child: Column(
                              children: [
                                // Account Info Widget
                                AccountInfo(user: state.user!),
                                const SizedBox(height: 20),
                                BlocProvider<SubscriptionCubit>(
                                  create: (_) => SubscriptionCubit(),
                                  child: UnSubscriptionWidget(
                                    userId: state.user!.id!,
                                    isFollowed: isFollowed,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // New Widget: Account Trophies
                                AccountTrophies(userId: state.user!.id!),
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
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Column(
                            children: [
                              // Account Info Widget
                              AccountInfo(user: state.user!),
                              const SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              BlocProvider<SubscriptionCubit>(
                                create: (_) => SubscriptionCubit(),
                                child: SubscriptionWidget(
                                  userId: state.user!.id!,
                                  isFollowingPending: isFollowingPending,
                                  isFollowedPending: isFollowedPending,
                                  onSubscriptionButton: () {
                                    setState(() {
                                      isFollowingPending = !isFollowingPending;
                                      isFollowing = !isFollowing!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),

                              // New Widget: Account Trophies
                              AccountTrophies(userId: state.user!.id!),
                              PostsUserviewWidget(userId: state.user!.id!),
                            ],
                          ),
                        );
                      }

                      // status approved
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Column(
                          children: [
                            // Account Info Widget
                            AccountInfo(user: state.user!),
                            const SizedBox(height: 20),
                            BlocProvider<SubscriptionCubit>(
                              create: (_) => SubscriptionCubit(),
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

                    // user.id == userAuthenticated.id
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Column(
                        children: [
                          // Account Info Widget
                          AccountInfo(user: state.user!),
                          const SizedBox(height: 20),
                          // New Widget: Account Trophies
                          AccountTrophies(userId: state.user!.id!),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
