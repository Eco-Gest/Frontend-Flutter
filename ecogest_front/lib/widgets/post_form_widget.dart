// import 'package:ecogest_front/models/user_model.dart';
// import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
// import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
// import 'package:ecogest_front/views/post_detail_view.dart';
// import 'package:ecogest_front/widgets/app_bar.dart';
// import 'package:ecogest_front/widgets/bottom_bar.dart';
// import 'package:ecogest_front/widgets/date_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class PostFormWidget extends StatelessWidget {
//   PostFormWidget(UserModel? user, {super.key});
//   // bool? isChallenge;
//   // DateTime? startDate;
//   // DateTime? endDate;

//   UserModel? user;

//   static String name = 'postCreate';
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryController = TextEditingController();
//   final positionController = TextEditingController();
//   final tagController = TextEditingController();
//   final List<String> tags = List.empty();
//   final formKey = GlobalKey<FormState>();

//   void addTag(String newTag) {
//     tags.add(newTag);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class TogglePostType extends StatefulWidget {
//   TogglePostType({super.key, this.value});
//   String? value;

//   @override
//   State<TogglePostType> createState() => _TogglePostTypeState();
// }

// class _TogglePostTypeState extends State<TogglePostType> {
//   final List<bool> _selectedPostType = <bool>[true, false];

//   static const List<Widget> postType = <Widget>[Text('Geste'), Text('Défi')];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       child:
//           // Type
//           ToggleButtons(
//         onPressed: (int index) {
//           setState(() {
//             // The button that is tapped is set to true, and the others to false.
//             for (int i = 0; i < _selectedPostType.length; i++) {
//               _selectedPostType[i] = i == index;
//               widget.value = _selectedPostType[index].toString();
//             }
//           });
//         },
//         constraints: BoxConstraints(
//             minWidth: (MediaQuery.of(context).size.width - 36) / 2,
//             minHeight: 50.0),
//         isSelected: _selectedPostType,
//         children: postType,
//       ),
//     );
//   }
// }

// class DropdownCategory extends StatelessWidget {
//   DropdownCategory({super.key});

//   String? category;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Language'),
//           DropdownButton(
//             value: 'Mobilité',
//             items: const [
//               DropdownMenuItem(
//                 value: 'Mobilité',
//                 child: Text('Mobilité'),
//               ),
//               DropdownMenuItem(
//                 value: 'Alimentation',
//                 child: Text('Alimentation'),
//               ),
//               DropdownMenuItem(
//                 value: 'Déchets',
//                 child: Text('Déchets'),
//               ),
//               DropdownMenuItem(
//                 value: 'Biodiversité',
//                 child: Text('Biodiversité'),
//               ),
//               DropdownMenuItem(
//                 value: 'Energie',
//                 child: Text('Energie'),
//               ),
//               DropdownMenuItem(
//                 value: 'Do It Yourself',
//                 child: Text('Do It Yourself'),
//               ),
//               DropdownMenuItem(
//                 value: 'Technologies',
//                 child: Text('Technologies'),
//               ),
//               DropdownMenuItem(
//                 value: 'Seconde vie',
//                 child: Text('Seconde vie'),
//               ),
//               DropdownMenuItem(
//                 value: 'Divers',
//                 child: Text('Divers'),
//               ),
//             ],
//             onChanged: (value) {
//               category = value;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DropdownLevel extends StatelessWidget {
//   DropdownLevel({super.key});

//   String? level;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Level'),
//           DropdownButton(
//             value: 'easy',
//             items: const [
//               DropdownMenuItem(
//                 value: 'easy',
//                 child: Text('Facile'),
//               ),
//               DropdownMenuItem(
//                 value: 'medium',
//                 child: Text('Moyen'),
//               ),
//               DropdownMenuItem(
//                 value: 'hard',
//                 child: Text('Difficile'),
//               ),
//             ],
//             onChanged: (value) {
//               level = value;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
