// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App()); // <- root
}

class App extends StatelessWidget {
  // statelesswidget을 상속받은 클래스를 생성
  // build 메소드를 만들어야 하며, 이는 UI를 리턴함
  // statelesswidget은 생성된 화면을 띄워주기만 함.

  @override
  Widget build(BuildContext context) {
    // 앱의 가장 기본이 되는 class
    // 리턴하는 값은 material이나 cupertino 앱을 리턴해야만 함.
    // material : 안드로이드 디자인 시스템 <- 기본적으로 해당 디자인을 사용
    // cupertino : 애플 디자인 시스템

    // return MaterialApp(); // # output1 : only black display
    return MaterialApp(
      // home: Text('Hello World'), // # output2
      // 구분을 용이하게하기 위해서 named parameter를 사용 (ex. home, appBar, centerTitle...)
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 3, //appbar 하단의 그림자 추가
          title: const Text('Hello Flutter'),
        ),
        // body: Text('Hello World!'),
        body: const Center(
          child: Text('Hello World!'), // Text? 등은 반드시 필요한 항목은 아니며, 필요에 따라 입력
        ),
      ),
    );
  }
}
