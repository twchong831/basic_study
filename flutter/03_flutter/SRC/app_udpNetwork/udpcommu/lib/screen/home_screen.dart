import 'package:flutter/material.dart';
import 'package:udpcommu/widgets/checkable_icon_button_widget.dart';
import 'package:udpcommu/widgets/text_editor_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String ipAddress = '127.0.0.1';
  int portNum = 5000;

  WidgetTextField ipText = WidgetTextField(
    label: 'IP Address',
    hint: 'xxx.xxx.xxx.xxx',
  );

  beUpdated() {
    setState(() {
      ipAddress = ipText.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UDP test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ipText,
                  // child: WidgetTextField(
                  //   label: 'IP Address',
                  //   hint: 'xxx.xxx.xxx.xxx',
                  // ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: WidgetTextField(
                    label: 'Port Num.',
                    hint: '5000',
                  ),
                ),
              ],
            ),
            CheckableIconWidget(
              iconOn: const Icon(Icons.radio_button_on_rounded),
              iconOff: const Icon(Icons.radio_button_off_rounded),
              size: 40,
              ip: ipText.getData(),
            ),
          ],
        ),
      ),
    );
  }
}
