import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/widgets/account/approve_or_decline_subscription_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UnSubscriptionWidget extends StatefulWidget {
  UnSubscriptionWidget(
      {super.key,
      required this.userId,
      required this.isFollowed,
    });

  int userId;
  bool isFollowed;

  static String name = 'search';

  @override
  _UnSubscriptionWidget createState() => _UnSubscriptionWidget();
}

class _UnSubscriptionWidget extends State<UnSubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFollowed = widget.isFollowed;

    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
      if (state is SubscriptionStateInitial) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: Text(
              "Me désabonner",
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: isFollowed
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().unSubscribe(widget.userId);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              context.pushNamed(UserView.name, pathParameters: {
                'id': widget.userId.toString(),
              });
            },
          ),
          if (isFollowed) ...[
            ApproveOrDeclineSubscriptionWidget(
              userId: widget.userId,
              isFollowed: isFollowed,
              onApproveOrDeclineButton: () {
                setState(() {
                  isFollowed = !isFollowed;
                });
              },
            ),
          ]
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
              fixedSize: isFollowed
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().unSubscribe(widget.userId);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              context.pushNamed(UserView.name, pathParameters: {
                'id': widget.userId.toString(),
              });
            },
          ),
          if (isFollowed) ...[
            ApproveOrDeclineSubscriptionWidget(
              userId: widget.userId,
              isFollowed: isFollowed,
              onApproveOrDeclineButton: () {
                setState(() {
                  isFollowed = !isFollowed;
                });
              },
            ),
          ]
        ],
      );
    });
  }
}
