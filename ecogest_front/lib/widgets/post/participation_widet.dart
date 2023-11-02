import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:ecogest_front/state_management/posts/participation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipationWidget extends StatelessWidget {
  ParticipationWidget(
      {super.key, required this.isAlreadyParticipant, required this.postId});

  bool isAlreadyParticipant;
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
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
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
            },
            child: const Text('Participer au défi'),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
