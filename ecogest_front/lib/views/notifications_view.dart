import 'package:ecogest_front/state_management/notifications/notifications_cubit.dart';
import 'package:ecogest_front/views/post_detail_view.dart';
import 'package:ecogest_front/views/user_view.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsView extends StatelessWidget {
  static String name = 'notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Notifications'),
      bottomNavigationBar: AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<NotificationsCubit>(
              create: (context) {
                final cubit = NotificationsCubit();
                cubit.getNotifications();
                return cubit;
              },
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                if (state is NotificationsStateInitial ||
                    state is NotificationsStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NotificationsStateError) {
                  return Center(child: Text(state.message));
                } else if (state is NotificationsStateSuccess) {
                  if (state.notifications!.isEmpty) {
                    return const Center(
                      child: Text('Pas de notifications'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.notifications!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.notifications!.elementAt(index).title!),
                      leading: CircleAvatar(
                        child:
                            state.notifications!.elementAt(index).user?.image ==
                                    null
                                ? Image.asset('assets/profile.jpg')
                                : Image.network(
                                    state.notifications!
                                        .elementAt(index)
                                        .user!
                                        .image!,
                                    fit: BoxFit.cover),
                      ),
                      onTap: () {
                        if (state.notifications!.elementAt(index).post?.id !=
                            null) {
                          context
                              .pushNamed(PostDetailView.name, pathParameters: {
                            'id': state.notifications!
                                .elementAt(index)
                                .post!
                                .id!
                                .toString(),
                          });
                        } else {
                          context.pushNamed(UserView.name, pathParameters: {
                            'id': state.notifications!
                                .elementAt(index)
                                .user!
                                .id!
                                .toString(),
                          });
                        }
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            )
          ],
        ),
      ),
    );
  }
}
