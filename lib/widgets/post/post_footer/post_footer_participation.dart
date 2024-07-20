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
    // Bouton pour participer au défi
    if (!isAlreadyParticipant) {
      return BlocBuilder<ParticipationCubit, ParticipationState>(
        builder: (context, state) {
          Future<void> postModalAction(
              BuildContext context, bool isParticipation) {
            return showDialog<void>(
              context: context,
              builder: (BuildContext buildContext) {
                return AlertDialog(
                  title: const Text(
                      "Souhaitez-vous vraiment participer au défi ?"),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Oui'),
                      onPressed: () {
                        context
                            .read<ParticipationCubit>()
                            .createParticipation(postId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "C'est parti ! Vous participez désormais à ce défi."),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Non'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

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
              postModalAction(context, true);
            },
            child: const Text('Participer au défi'),
          );
        },
      );
    }

    // Bouton pour terminer le défi
    else if (canEndChallenge) {
      return BlocBuilder<ParticipationCubit, ParticipationState>(
        builder: (context, state) {
          Future<void> postModalAction(
              BuildContext context, bool isParticipation) {
            return showDialog<void>(
              context: context,
              builder: (BuildContext buildContext) {
                return AlertDialog(
                  title:
                      const Text("Souhaitez-vous vraiment terminer ce défi ?"),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Oui'),
                      onPressed: () {
                        context.read<ParticipationCubit>().endChallenge(postId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Bravo ! Vous avez terminé le défi avec succès."),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Non'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

          if (state is ParticipationStateSuccess) {
            return const SizedBox.shrink();
          } else if (state is ParticipationStateError) {
            return Center(child: Text(state.message));
          }
          return FilledButton(
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(15),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              postModalAction(context, false);
            },
            child: const Text('Terminer le défi'),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
