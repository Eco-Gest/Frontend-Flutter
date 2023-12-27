import 'package:date_field/date_field.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/views/account_view.dart';
import 'package:ecogest_front/widgets/account/checkbox_private_account.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateAccountWidget extends StatelessWidget {
  UpdateAccountWidget({super.key, required this.user});
  final formKey = GlobalKey<FormState>();

  UserModel user;
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
    usernameController.text = user.username ?? "";
    imageController.text = user.image ?? "";
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
                      if (state is UserSuccess) {
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
                                                  image: imageController.text,
                                                  isPrivate:
                                                      isPrivateController);
                                          GoRouter.of(context)
                                              .pushNamed(AccountView.name);
                                        }
                                      },
                                      child: const Text('Mettre à jour mon profil'),
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
