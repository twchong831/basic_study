import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> dropDownList = [
    '1',
    '2',
    '3',
    '4',
  ];
  final List<String> dropDownList2 = [
    'st',
    'stt',
    'stttt',
  ];

  String selectItem = '1';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drop_down TEST'),
        ),
        body: Row(children: [
          DropdownButton(
            value: selectItem,
            items: dropDownList.map(
              (String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              },
            ).toList(),
            onChanged: (dynamic value) {
              setState(() {
                selectItem = value;
                print("update -> $selectItem");
              });
            },
          )
        ]),
      ),
    );
  }
}
