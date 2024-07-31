import 'package:flutter/material.dart';

class CheckableIconWidget extends StatefulWidget {
  final Icon iconOn;
  final Icon iconOff;
  final double size;
  final String ip;

  const CheckableIconWidget({
    super.key,
    required this.iconOn,
    required this.iconOff,
    required this.size,
    required this.ip,
  });

  @override
  State<CheckableIconWidget> createState() => _CheckableIconWidgetState();
}

class _CheckableIconWidgetState extends State<CheckableIconWidget> {
  bool isChecked = false;

  onChecked() {
    setState(() {
      isChecked = !isChecked;
      if (isChecked) {
        print(isChecked);
        print("IP : ${widget.ip}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onChecked,
      icon: isChecked ? widget.iconOn : widget.iconOff,
      iconSize: widget.size,
    );
  }
}
