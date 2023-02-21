import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TEXTMODE {
  ip, //ip address
  port, //port number.
  txt, //some text
}

class WidgetTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool onlyNum;

  // String inputTxt = "";

  WidgetTextField({
    super.key,
    required this.label,
    required this.hint,
    this.onlyNum = false,
  });

  final edController = TextEditingController();

  @override
  State<WidgetTextField> createState() => _WidgetTextFieldState();

  String getData() {
    return edController.text;
  }
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  // final edController = TextEditingController();

  void isCHANGED() {
    // if (edController.text.isNotEmpty) {
    //   // print("changed txt");
    //   widget.inputTxt = edController.text;
    // }
  }

  // void isChanged(String txt) {
  //   print("controller : ${edController.text}");
  //   print("input : $txt");
  // }

  @override
  void initState() {
    super.initState();
    // edController.addListener((isCHANGED));
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.onlyNum) {
      // text mode
      return TextField(
        controller: widget.edController,
        decoration: InputDecoration(
          label: Text(widget.label),
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
          border: const OutlineInputBorder(),
        ),
        // onChanged: (value) => isChanged(value),
      );
    } else {
      // only number mode
      return TextField(
        controller: widget.edController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // limit number input only
        ],
        decoration: InputDecoration(
          label: Text(widget.label),
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
          border: const OutlineInputBorder(),
        ),
        // onChanged: (value) => isChanged(value),
      );
    }
  }
}
