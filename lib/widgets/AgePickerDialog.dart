import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AgePickerDialog extends StatefulWidget {
  final int initialAge;

  AgePickerDialog({super.key, required this.initialAge});

  @override
  _AgePickerDialogState createState() => _AgePickerDialogState();
}

class _AgePickerDialogState extends State<AgePickerDialog> {
  late int selectedAge;

  @override
  void initState() {
    super.initState();
    selectedAge = widget.initialAge;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Age'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NumberPicker(
            value: selectedAge,
            minValue: 18,
            maxValue: 100,
            onChanged: (value) => setState(() => selectedAge = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(selectedAge),
          child: const Text('OK'),
        ),
      ],
    );
  }}