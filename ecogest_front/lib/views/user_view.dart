import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserView extends StatelessWidget {
  UserView({Key? key, required int userId});

  int? userId;

  static String name = 'account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: ""),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<UserCubit>(
              create: (context) {
                final cubit = UserCubit();
                cubit.getUser(userId!);
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: ListView(
                        children: [
                          // Account Info Widget
                          AccountInfo(user: state.user),
                          SizedBox(height: 20),
                          // New Widget: Account Trophies
                          AccountTrophies(),
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
