import 'package:app_thirddemension/files/pcdreader.dart';
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
  // FileSystem pcdFiles = FileSystem();
  PCDReader pcdReader = PCDReader(path: '');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("load File & Display Point Cloud"),
        ),
        body: Row(
          children: [
            TextButton(
              onPressed: () async {
                print('press');
                final points = await pcdReader.read('');
                print('check generate point : ${points.length}');
                setState(() {});
              },
              child: const Text('load file list'),
            )
          ],
        ),
      ),
    );
  }
}
