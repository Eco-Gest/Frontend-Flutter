import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/views/users/account_view.dart';
import 'package:ecogest_front/widgets/account/checkbox_private_account.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

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
    final DateTime defaultDate = DateTime.now().subtract(Duration(days: 365 * 20));
    

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
                                    initialValue: birthdate ?? defaultDate,
                                    initialPickerDateTime: birthdate ?? defaultDate,
                                    mode: DateTimeFieldPickerMode.date,
                                    dateFormat: DateFormat.yMMMd('fr_FR'),
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Date d\'anniversaire',
                                    ),
                                    onChanged: (DateTime? value) {
                                      birthdate = value;
                                    },
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text('Sélectionnez une image'),
                                    GestureDetector(
                                      onTap: getImage,
                                      child: _buildImage(user.image),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: (MediaQuery.of(context).size.width +
                                            60) /
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

  Widget _buildImage(String? userImageUrl) {
    if (_image == null && userImageUrl == null) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
              image: DecorationImage(
                image: _image != null
                    ? (kIsWeb
                        ? NetworkImage(_image!.path) as ImageProvider<Object>
                        : FileImage(_image!))
                    : NetworkImage(userImageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(
            Icons.add,
            color: Colors.grey.withOpacity(0.6),
            size: 40,
          ),
        ],
      );
    }
  }
}
