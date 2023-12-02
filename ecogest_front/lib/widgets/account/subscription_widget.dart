import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:ecogest_front/widgets/account/approve_or_decline_subscription_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionWidget extends StatelessWidget {
  SubscriptionWidget(
      {super.key,
      required this.userId,
      required this.status,
      this.hasFollowRequest});

  int userId;
  String status;
  bool? hasFollowRequest;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
      if (state is SubscriptionStateInitial) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FilledButton(
            child: Text(
              status == "subscribe" ? 'Suivre' : "Annuler",
            ),
            style: FilledButton.styleFrom(
              backgroundColor:
                  status == "subscribe" ? lightColorScheme.primary : Colors.white,
              fixedSize: hasFollowRequest!
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().subscription(userId, status);
              status = status == "subscribe" ? "cancel" : "subscribe";
            },
          ),
          ApproveOrDeclineSubscriptionWidget(
              userId: userId,
              hasFollowRequest:
                  hasFollowRequest!),
        ]);
      }
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FilledButton(
          child: Text(
            status == "subscribe" ? 'Suivre' : "Annuler",
          ),
          style: FilledButton.styleFrom(
            backgroundColor:
                status == "subscribe" ? lightColorScheme.primary : Colors.white,
            fixedSize: hasFollowRequest!
                ? Size(210, 50)
                : Size((MediaQuery.of(context).size.width) / 2, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            context.read<SubscriptionCubit>().subscription(userId, status);
            status = status == "subscribe" ? "cancel" : "subscribe";
          },
        ),
        ApproveOrDeclineSubscriptionWidget(
            userId: userId,
            hasFollowRequest:
                hasFollowRequest!),
      ]);
    });
  }
}
