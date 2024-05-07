import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/subscription_model.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:ecogest_front/widgets/account/approve_or_decline_subscription_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class SubscriptionWidget extends StatefulWidget {
  SubscriptionWidget(
      {super.key,
      required this.userId,
      required this.isFollowingPending,
      required this.isFollowedPending,
      required this.onSubscriptionButton});

  int userId;
  bool isFollowingPending;
  bool isFollowedPending;

  final VoidCallback onSubscriptionButton;

  @override
  _SubscriptionWidget createState() => _SubscriptionWidget();
}

class _SubscriptionWidget extends State<SubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFollowed = widget.isFollowedPending;
    int userId = widget.userId;
    bool isFollowing = widget.isFollowingPending;
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
      if (state is SubscriptionStateSuccess) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: isFollowed
                  ? const Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              widget.onSubscriptionButton;
              context
                  .read<SubscriptionCubit>()
                  .subscription(userId, isFollowing);
              isFollowing = !isFollowing;
            },
            child: const Text(
              "Annuler",
              style: TextStyle(color: Colors.black),
            ),
          ),
          if (isFollowed) ...[
            ApproveOrDeclineSubscriptionWidget(
              userId: userId,
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

      if (state is SubscriptionCancelStateSuccess) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor:
                  context.read<ThemeSettingsCubit>().state.isDarkMode
                      ? darkColorScheme.primary
                      : lightColorScheme.primary,
              fixedSize: isFollowed
                  ? Size(210, 50)
                  : Size((MediaQuery.of(context).size.width) / 2, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              widget.onSubscriptionButton;
              context
                  .read<SubscriptionCubit>()
                  .subscription(userId, isFollowing);
              isFollowing = !isFollowing;
            },
            child: const Text(
              'Suivre',
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (isFollowed) ...[
            ApproveOrDeclineSubscriptionWidget(
              userId: userId,
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

      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: (isFollowing
                ? Colors.white
                : context.read<ThemeSettingsCubit>().state.isDarkMode
                    ? darkColorScheme.primary
                    : lightColorScheme.primary),
            fixedSize: isFollowing
                ? Size(210, 50)
                : Size((MediaQuery.of(context).size.width) / 2, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            widget.onSubscriptionButton;
            context.read<SubscriptionCubit>().subscription(userId, isFollowing);
            isFollowing = !isFollowing;
          },
          child: Text(
            isFollowing ? 'Annuler' : 'Suivre',
            style: TextStyle(color: isFollowing ? Colors.black : Colors.white),
          ),
        ),
        if (isFollowed) ...[
          ApproveOrDeclineSubscriptionWidget(
            userId: userId,
            isFollowed: isFollowed,
            onApproveOrDeclineButton: () {
              setState(() {
                isFollowed = !isFollowed;
              });
            },
          ),
        ]
      ]);
    });
  }
}
