import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/widgets/account/subscription_widget.dart';
import 'package:ecogest_front/widgets/account/unsubscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/color_schemes.g.dart';

class UserView extends StatelessWidget {
  UserView({Key? key, required this.userId});

  final int userId;

  static String name = 'users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: "Profil"),
      bottomNavigationBar: const AppBarFooter(),
      body: BlocProvider<UserCubit>(
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
                final userAuthenticated = authenticationState.user;
                final userIsSubscribed = userAuthenticated!.following!
                    .where((subscription) =>
                        subscription!.followingId == state.user!.id!)
                    .firstOrNull;

                final userAuthenticatedHasFollowRequest = userAuthenticated!
                    .followers!
                    .where((subscription) =>
                        subscription!.followerId == state.user!.id!)
                    .firstOrNull;

                String? status = userIsSubscribed?.status;
                bool? userAuthenticatedHasFollowRequestStatus =
                    userAuthenticatedHasFollowRequest?.status == "pending"
                        ? true
                        : false;

                if (userAuthenticated.id != state.user!.id!) {
                  // user private
                  if (state.user!.isPrivate!) {
                    // status pending
                    if (status == "pending" || status == null) {
                      status = status == null ? "subscribe" : "cancel";
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Column(
                          children: [
                            // Account Info Widget
                            AccountInfo(user: state.user!),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width,
                                color: lightColorScheme.outline,
                              ),
                            ),
                            SizedBox(height: 20),
                            BlocProvider<SubscriptionCubit>(
                              create: (_) => SubscriptionCubit(),
                              child: SubscriptionWidget(
                                  userId: state.user!.id!,
                                  status: status,
                                  userAuthenticatedHasFollowRequestStatus:
                                      userAuthenticatedHasFollowRequestStatus),
                            ),
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
                          SizedBox(height: 20),
                          BlocProvider<SubscriptionCubit>(
                            create: (_) => SubscriptionCubit(),
                            child: UnSubscriptionWidget(
                              userId: state.user!.id!,
                              userAuthenticatedHasFollowRequestStatus:
                                  userAuthenticatedHasFollowRequestStatus,
                            ),
                          ),
                          SizedBox(height: 20),

                          // New Widget: Account Trophies
                          AccountTrophies(userId: state.user!.id!),
                        ],
                      ),
                    );
                  }

                  // user public
                  // status pending
                  if (status == "pending" || status == null) {
                    status = status == null ? "subscribe" : "cancel";
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Column(
                        children: [
                          // Account Info Widget
                          AccountInfo(user: state.user!),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          BlocProvider<SubscriptionCubit>(
                            create: (_) => SubscriptionCubit(),
                            child: SubscriptionWidget(
                                userId: state.user!.id!,
                                status: status,
                                userAuthenticatedHasFollowRequestStatus:
                                    userAuthenticatedHasFollowRequestStatus),
                          ),
                          SizedBox(height: 20),

                          // New Widget: Account Trophies
                          AccountTrophies(userId: state.user!.id!),
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
                        SizedBox(height: 20),
                        BlocProvider<SubscriptionCubit>(
                          create: (_) => SubscriptionCubit(),
                          child: UnSubscriptionWidget(
                            userId: state.user!.id!,
                            userAuthenticatedHasFollowRequestStatus:
                                userAuthenticatedHasFollowRequestStatus,
                          ),
                        ),
                        SizedBox(height: 20),

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
                      SizedBox(height: 20),
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
    );
  }
}
