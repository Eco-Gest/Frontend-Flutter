import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApproveOrDeclineSubscriptionWidget extends StatefulWidget {
  ApproveOrDeclineSubscriptionWidget(
      {super.key,
      required this.userId,
      required this.isFollowed,
      required this.onApproveOrDeclineButton});

  int userId;
  bool isFollowed;
  final VoidCallback onApproveOrDeclineButton;

  @override
  _ApproveOrDeclineSubscriptionWidget createState() =>
      _ApproveOrDeclineSubscriptionWidget();
}

class _ApproveOrDeclineSubscriptionWidget
    extends State<ApproveOrDeclineSubscriptionWidget> {
  static List<String> selectabelChoiceApproveOrDecline = [
    "Accepter",
    "Refuser"
  ];

  bool hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    int userId = widget.userId;
    bool isFollowed = widget.isFollowed;
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
      if (state is! SubscriptionApproveOrDeclineStateSuccess &&
          hasAnswered == false) {
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
                  widget.onApproveOrDeclineButton;
                  hasAnswered = true;
                },
              ),
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
