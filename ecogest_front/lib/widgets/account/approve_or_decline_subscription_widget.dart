import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApproveOrDeclineSubscriptionWidget extends StatelessWidget {
  ApproveOrDeclineSubscriptionWidget(
      {super.key,
      required this.userId,
      required this.hasFollowRequest});

  int userId;
  bool hasFollowRequest;

  static List<String> selectabelChoiceApproveOrDecline = [
    "Accepter",
    "Refuser"
  ];

  @override
  Widget build(BuildContext context) {
    if (hasFollowRequest) {
      return Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            width: 210,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField(
              value: selectabelChoiceApproveOrDecline[0],
              isExpanded: true,
              items: selectabelChoiceApproveOrDecline.map((String val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val + " la demande",
                  ),
                );
              }).toList(),
              onChanged: (value) {
                context
                    .read<SubscriptionCubit>()
                    .approveOrDeclineSubscription(userId, value!);
              },
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
