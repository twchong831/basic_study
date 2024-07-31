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

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA", child: Text("USA")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "korea", child: Text("korea")),
      const DropdownMenuItem(value: "USA", child: Text("USA")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> setSecondDropDownMenu(int sel) {
    List<DropdownMenuItem<String>> nullVal = [
      const DropdownMenuItem(value: "0.0.0.0", child: Text("0.0.0.0")),
    ];
    if (sel == 1) {
      return dropdownItems1;
    } else if (sel == 2) {
      return dropdownItems2;
    }

    return nullVal;
  }

  String selectItem = '1';
  String selectItem2 = '';

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
        body: Row(
          children: [
            Row(
              children: [
                DropdownButton(
                  // value: selectItem,
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
                ),
                DropdownButton(
                  // value: selectItem2,
                  items: setSecondDropDownMenu(int.parse(selectItem)),
                  onChanged: (dynamic value) {
                    setState(() {
                      selectItem2 = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
