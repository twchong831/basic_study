import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_model.dart';
import 'package:webtoonapp/services/api_service.dart';
import 'package:webtoonapp/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

/*
  //using statefulwidget
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;
  
  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }
*/
  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    // print(isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Today's 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          // snapshot : ui 변화를 알려줌
          if (snapshot.hasData) {
            /*return ListView(
              children: [
                for (var webtoon in snapshot.data!) Text(webtoon.title)
              ],
            );*/
            /*
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // print(index); // index는 스크롤 될때에만 증감함.
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
            );
            */
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, //draw ui
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        // index는 스크롤 될때에만 증감함.
        var webtoon = snapshot.data![index];
        return WebtoonWidget(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
        // return Text(webtoon.title);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
