//call APi
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

// https dev package
// pubspec.yaml에 패키지 추가
  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); //package use
    // get의 리턴 타입은 future. 현재 발생하지 않고 이후에 값이 발생함
    // 해당 명령이 종료되기를 기다리지 않고 다른 명령을 먼저 수행할 수 있음
    // async, await 비동기 싱크를 사용하여 해당 명령이 종료되기를 기다림

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var i in webtoons) {
        // print(i);
        // final toon = WebtoonModel.fromJson(i); // api로부터 획득한 json데이터를 파싱함.
        // print(toon.title);
        webtoonInstances.add(WebtoonModel.fromJson(i));
      }
      return webtoonInstances;
      // return;
    }
    throw Error();
  }
}
