import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:ecogest_front/state_management/posts/participation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// PostFooterParticipation is a widget that displays the participation
// actions that can be done on a post of challnege type :
// participate, end challenge

class PostFooterParticipation extends StatelessWidget {
  PostFooterParticipation(
      {super.key,
      required this.isAlreadyParticipant,
      required this.postId,
      required this.canEndChallenge});

  bool isAlreadyParticipant;
  bool canEndChallenge;
  int postId;

  @override
  Widget build(BuildContext context) {
    if (!isAlreadyParticipant) {
      return BlocBuilder<ParticipationCubit, ParticipationState>(
        builder: (context, state) {
          if (state is ParticipationStateSuccess) {
            return const SizedBox.shrink();
          } else if (state is ParticipationStateError) {
            return Center(child: Text(state.message));
          }
          return FilledButton(
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              context.read<ParticipationCubit>().createParticipation(postId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vous participer désormais à ce challenge'),
                ),
              );
            },
            child: const Text('Participer au défi'),
          );
        },
      );
    } else if (canEndChallenge) {
      return BlocBuilder<ParticipationCubit, ParticipationState>(
        builder: (context, state) {
          if (state is ParticipationStateSuccess) {
            return const SizedBox.shrink();
          } else if (state is ParticipationStateError) {
            return Center(child: Text(state.message));
          }
          return FilledButton(
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              context.read<ParticipationCubit>().endChallenge(postId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vous avez terminé ce challenge'),
                ),
              );
            },
            child: const Text('Terminer le défi'),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
