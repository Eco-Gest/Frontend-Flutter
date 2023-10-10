import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class DateWidget extends StatelessWidget {
  DateWidget({super.key, this.isChallenge, this.date});
  bool? isChallenge;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width - 36),
          ),
          child: DateTimeFormField(
            initialValue: DateTime.now(),
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black45),
              errorStyle: TextStyle(color: Colors.redAccent),
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.event_note),
              labelText: 'Date',
            ),
            onDateSelected: (DateTime value) {
              date = value;
            },
          ),
        ),
      ],
    );
  }
}
