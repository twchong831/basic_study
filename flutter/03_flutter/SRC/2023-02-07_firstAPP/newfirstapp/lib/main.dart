import 'package:flutter/material.dart';
import 'package:newfirstapp/widgets/buttons.dart';
import 'package:newfirstapp/widgets/currency_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818), // set background color
        body: SingleChildScrollView(
          child: Padding(
            // set padding
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // make column
              children: [
                SizedBox(
                  //임의의 위젯을 삽입
                  height: 80,
                  child: Container(
                    // sizedwidget 확인용 색 할당
                    color: Colors.blue,
                  ),
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
                          'Hey, selena',
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
                ),
                SizedBox(
                  height: 60,
                  child: Container(
                    color: Colors.blue, // check sizedbox
                  ),
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 5,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  '\$5 194 482',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                      text: 'Transfer',
                      bgColor: Colors.amber,
                      textcolor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0xFF1F2123),
                      textcolor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View ALL',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                const CurrencyCard(
                  name: 'Euro',
                  code: 'EUR',
                  amount: '6 428',
                  icon: Icons.euro_rounded,
                  isInverted: false,
                  offSet: Offset(0, 0),
                ),
                const CurrencyCard(
                  name: 'Bitcoin',
                  code: 'BTC',
                  amount: '9 785',
                  icon: Icons.currency_bitcoin,
                  isInverted: true,
                  offSet: Offset(0, -20),
                ),
                const CurrencyCard(
                  name: 'Dollar',
                  code: 'USD',
                  amount: '428',
                  icon: Icons.attach_money_outlined,
                  isInverted: false,
                  offSet: Offset(0, -40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
