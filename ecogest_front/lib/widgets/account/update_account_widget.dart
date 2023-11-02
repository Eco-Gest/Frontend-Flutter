import 'package:date_field/date_field.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/views/account_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateAccountWidget extends StatefulWidget {
  UpdateAccountWidget(
      {super.key, required this.user, required this.isPrivateController});

  UserModel user;
  bool isPrivateController;

  @override
  _UpdateAccountWidget createState() => _UpdateAccountWidget();
}

class _UpdateAccountWidget extends State<UpdateAccountWidget> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final imageController = TextEditingController();
  final positionController = TextEditingController();
  final biographyController = TextEditingController();
  DateTime? birthdate;

  bool valideUsername(String username) {
    //regular expression to check if string
    RegExp usernameValid = RegExp(r"^[A-Za-z0-9_]{5,29}$");
    String usernameToTest = username.trim();
    if (usernameValid.hasMatch(usernameToTest)) {
      return true;
    } else {
      return false;
    }
  }

  bool imageValidation(String? image) {
    final List<String> fileFormatImg3Chars = ['jpg', 'png', 'gif', 'svg'];
    final List<String> fileFormatImg4Chars = [
      'webp',
      'jpeg',
    ];
    if (image == null || image.isEmpty) {
      return true;
    } else if (image.length <= 15) {
      return false;
    } else {
      final startOfUrl = image.substring(0, 8);
      final last3CharOfUrl = image.substring(image.length - 3);
      final last4CharOfUrl = image.substring(image.length - 4);
      if (startOfUrl == 'http://' || startOfUrl == 'https://') {
        if (fileFormatImg3Chars.contains(last3CharOfUrl) ||
            fileFormatImg4Chars.contains(last4CharOfUrl)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = widget.user;
    usernameController.text = user!.username ?? "";
    imageController.text = user.image ?? "";
    positionController.text = user.position ?? "";
    biographyController.text = user.biography ?? "";
    birthdate = user.birthdate == '' || user.birthdate == null
        ? null
        : DateTime.parse(user.birthdate!);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider(
              create: (context) => UserCubit(),
              child: Builder(
                builder: (context) {
                  return BlocListener<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Erreur lors de la mise à jour de vos données.')),
                        );
                      }
                      if (state is UserSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mise à jour réussie')),
                        );
                      }
                    },
                    child: Form(
                      key: formKey,
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        BlocBuilder<UserCubit, UserState>(
                          builder: (BuildContext context, UserState state) {
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nom d\'utilisateur',
                                      hintText: user.username ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) => valideUsername(value!)
                                        ? null
                                        : 'Veuillez entrer un nom d\'utilisateur valide',
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Profil privé '),
                                  trailing: Checkbox(
                                    activeColor: EcogestTheme.primary,
                                    value: widget.isPrivateController,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.isPrivateController = value!;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: biographyController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Biographie',
                                      hintText: user.biography ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: positionController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Géolocalisation',
                                      hintText: user.position ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                    minWidth:
                                        (MediaQuery.of(context).size.width -
                                            36),
                                  ),
                                  child: DateTimeFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    initialValue: DateTime(
                                        DateTime.now().year - 20,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    initialDate: DateTime(
                                        DateTime.now().year - 20,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    mode: DateTimeFieldPickerMode.date,
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Dat d\'anniversaire',
                                    ),
                                    onDateSelected: (value) {
                                      birthdate = value;
                                    },
                                  ),
                                ),

                                // image
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: imageController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Image',
                                      hintText: 'Entrez l\'url d\'une image',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) => imageValidation(
                                            imageController.text)
                                        ? null
                                        : 'Lien vers l\'image doit être une url avec une extension .jpg, .png, .gif, .svg, .webp ou .jpeg',
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            26) /
                                        2,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Mise à jour des données en cours...')),
                                          );
                                          context
                                              .read<UserCubit>()
                                              .updateUserAccount(
                                                  username:
                                                      usernameController.text,
                                                  position:
                                                      positionController.text,
                                                  biography:
                                                      biographyController.text,
                                                  birthdate: birthdate,
                                                  image: imageController.text,
                                                  isPrivate: widget
                                                      .isPrivateController);
                                        }
                                      },
                                      child: const Text('Publier'),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
