import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF181818), // set background color
        body: Padding(
          // set padding
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            // make column
            children: [
              const SizedBox(
                //임의의 위젯을 삽입
                height: 80,
                // child: Container(  // sizedwidget 확인용 색 할당
                //   color: Colors.blue,
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, //정렬
                // row의 main axis는 가로축
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // 내부 정렬
                    // col의 main axis는 세로축
                    children: [
                      const Text(
                        'hey selena',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'welcome back',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
