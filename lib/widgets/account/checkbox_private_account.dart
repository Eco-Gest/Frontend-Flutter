import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';

class CheckboxPrivateAccountWidget extends StatefulWidget {
  CheckboxPrivateAccountWidget(
      {super.key, required this.changePrivateValue, required this.isPrivateController});

  final Function() changePrivateValue;
  bool isPrivateController;

  @override
  _CheckboxPrivateAccountWidget createState() =>
      _CheckboxPrivateAccountWidget();
}

class _CheckboxPrivateAccountWidget
    extends State<CheckboxPrivateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: const Text('Profil privé '),
        value: widget.isPrivateController,
        onChanged: (bool? value) {
          setState(() {
           widget.changePrivateValue();
           widget.isPrivateController = value!;
          });
        });
  }
}
