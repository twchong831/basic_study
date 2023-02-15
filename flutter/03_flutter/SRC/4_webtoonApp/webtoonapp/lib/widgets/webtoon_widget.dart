import 'package:flutter/material.dart';
import 'package:webtoonapp/screen/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonWidget({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //detect gesture
      onTap: () {
        Navigator.push(
          // push때 페이지가 새로 생성된것과 같은 효과를 줌
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ), // 새로운 페이지를 생성해줌
            // fullscreenDialog: true, // 새 페이지 출력 시, 아래에서 위로 출력됨 // hero 사용해서 주석화
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // for beariful moving
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge, // image round
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // image round
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
