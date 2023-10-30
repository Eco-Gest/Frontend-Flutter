import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:ecogest_front/views/user_view.dart';
import 'package:ecogest_front/widgets/account/approve_or_decline_subscription_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UnSubscriptionWidget extends StatelessWidget {
  UnSubscriptionWidget(
      {super.key,
      required this.userId,
      this.userAuthenticatedHasFollowRequestStatus});

  int userId;
  bool? userAuthenticatedHasFollowRequestStatus;

  static String name = 'search';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
      if (state is SubscriptionStateInitial) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: Text(
              "Me désabonner",
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: userAuthenticatedHasFollowRequestStatus!
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().unSubscribe(userId);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              context.pushNamed(UserView.name, pathParameters: {
                'id': userId.toString(),
              });
            },
          ),
          ApproveOrDeclineSubscriptionWidget(
              userId: userId,
              userAuthenticatedHasFollowRequestStatus:
                  userAuthenticatedHasFollowRequestStatus!),
        ]);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(
              "Me désabonner",
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: userAuthenticatedHasFollowRequestStatus!
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().unSubscribe(userId);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              context.pushNamed(UserView.name, pathParameters: {
                'id': userId.toString(),
              });
            },
          ),
          ApproveOrDeclineSubscriptionWidget(
              userId: userId,
              userAuthenticatedHasFollowRequestStatus:
                  userAuthenticatedHasFollowRequestStatus!),
        ],
      );
    });
  }
}
