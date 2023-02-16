import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  List<int> numbers = [];

  bool showTitle = true;

  void onClicked() {
    setState(() {
      // for refresh
      // 데이터가 변경되었음을 flutter에 알리기 위한 함수
      // 해당 함수가 실행되면, UI가 업데이트 됨
      counter = counter + 1;
      numbers.add(numbers.length);
    });
  }

  void toggled() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLageTitle() : const Text('Nothing to see'),
              Column(children: [
                Text(
                  '$counter',
                  style: const TextStyle(fontSize: 30),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onClicked,
                      iconSize: 40,
                      icon: const Icon(
                        Icons.add_box_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: toggled,
                      icon: const Icon(Icons.remove_red_eye_sharp),
                    ),
                  ],
                ),
                // for (var n in numbers) Text('$n'),
                Text(
                  '$numbers',
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLageTitle extends StatefulWidget {
  const MyLageTitle({
    super.key,
  });

  @override
  State<MyLageTitle> createState() => _MyLageTitleState();
}

class _MyLageTitleState extends State<MyLageTitle> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    print('initState!');
  }
  // initState는 한번만 선언되며
  // 항상 build 앞에 선언되어야 함
  // ui 생성 시 호출됨
  // 선언하지 않아도 문제는 없음

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose!");
  }
  // dispose로 자동완성할 수 있음
  // widget tree에서 ui가 제거될 때 호출됨
  // 선언하지 않아도 문제는 없음

  @override
  Widget build(BuildContext context) {
    //context : 상위 widget에 대한 정보를 가지고 있음
    print('build!');
    return Text(
      //remove const
      'Click Count',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context)
            .textTheme
            .titleLarge!
            .color, // (titleLarge!) check null safety
      ),
    );
  }
}
