//call APi
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_episode_model.dart';
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

// https dev package
// pubspec.yaml에 패키지 추가
  static Future<List<WebtoonModel>> getTodaysToons() async {
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

  static Future<WebtoonDetailModel> getToonByID(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse("$baseUrl/$id/episodes");
    List<WebtoonEpisodeModel> episodesInstances = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);

      for (var ep in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(ep));
      }

      return episodesInstances;
    }
    throw Error();
  }
}
