import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String label;
  final String hint;

  WidgetTextField({
    super.key,
    required this.label,
    required this.hint,
  });

  final edController = TextEditingController();

  String getData() {
    print("call get data");
    return edController.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: edController,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
