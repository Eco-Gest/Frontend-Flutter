import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/users_relation_model.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_state.dart';
import 'package:ecogest_front/widgets/account/approve_or_decline_subscription_widget.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class SubscriptionWidget extends StatefulWidget {
  SubscriptionWidget({
    super.key,
    required this.userId,
    required this.isFollowingPending,
    required this.isFollowedPending,
    required this.onSubscriptionButton,
  });

  final int userId;
  bool isFollowingPending;
  bool isFollowedPending;
  final VoidCallback onSubscriptionButton;

  @override
  _SubscriptionWidgetState createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  bool get isFollowing => widget.isFollowingPending;
  bool get isFollowed => widget.isFollowedPending;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersRelationCubit, UsersRelationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSubscriptionButton(context),
            if (isFollowed) ...[
              ApproveOrDeclineSubscriptionWidget(
                userId: widget.userId,
                isFollowed: isFollowed,
                onApproveOrDeclineButton: () {
                  setState(() {
                    widget.isFollowedPending = !isFollowed;
                  });
                },
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionButton(BuildContext context) {
    final isDarkMode = context.read<ThemeSettingsCubit>().state.isDarkMode;
    final primaryColor = isDarkMode ? darkColorScheme.primary : lightColorScheme.primary;

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: isFollowing ? Colors.white : primaryColor,
        fixedSize: Size(isFollowed ? 210 : MediaQuery.of(context).size.width / 2, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        widget.onSubscriptionButton();
        context.read<UsersRelationCubit>().subscription(widget.userId, isFollowing);
        setState(() {
          widget.isFollowingPending = !isFollowing;
        });
      },
      child: Text(
        isFollowing ? 'Annuler' : 'Suivre',
        style: TextStyle(color: isFollowing ? Colors.black : Colors.white),
      ),
    );
  }
}
