import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/views/account_view.dart';
import 'package:ecogest_front/widgets/account/checkbox_private_account.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAccountWidget extends StatefulWidget {
  UpdateAccountWidget({super.key, required this.user});
  final UserModel user;

  @override
  _UpdateAccountWidget createState() => _UpdateAccountWidget();
}

class _UpdateAccountWidget extends State<UpdateAccountWidget> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
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

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = widget.user;
    usernameController.text = user.username ?? "";
    positionController.text = user.position ?? "";
    biographyController.text = user.biography ?? "";
    birthdate = user.birthdate == '' || user.birthdate == null
        ? null
        : DateTime.parse(user.birthdate!);
    bool isPrivateController = user.isPrivate!;

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
                      if (state is UserAccountSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mise à jour réussie')),
                        );
                      }
                    },
                    child: Form(
                      key: formKey,
                      child: Column(children: <Widget>[
                        const SizedBox(height: 20),
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
                                CheckboxPrivateAccountWidget(
                                  isPrivateController: isPrivateController,
                                  changePrivateValue: () => {
                                    isPrivateController = !isPrivateController
                                  },
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
                                      labelText: 'Date d\'anniversaire',
                                    ),
                                    onDateSelected: (value) {
                                      birthdate = value;
                                    },
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text('Sélectionnez une image'),
                                    OutlinedButton(
                                      onPressed: getImage,
                                      child: _buildImage(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            26) /
                                        2,
                                    height: 50.0,
                                    child: FilledButton(
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
                                                  image: _image?.path ?? "",
                                                  isPrivate:
                                                      isPrivateController);
                                          GoRouter.of(context)
                                              .pushNamed(AccountView.name);
                                        }
                                      },
                                      child: const Text(
                                          'Mettre à jour mon profil'),
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

  Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }
}
