import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jootoon/models/webtoon_detail_model.dart';
import 'package:jootoon/models/webtoon_episode_model.dart';
import 'package:jootoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  /// Api 통신 시 pub.dev 사이트에서 http 패기지를 다운받아야 한다.
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');

    /// -> get 함수를 통해 api를 받아온다.
    /// Future 타입으로 반환하는 것은 보통 비동기 처리를 한다.
    /// async await(비동기) 처리를 하지 않을 시 다트가 url을 받는것 까지 기다리지 않고 바로 화면 출력을 실행할 수 있다.
    /// wait 처리 후 리턴 타입이 Future에서 Response로 변하는 것을 확인할 수 있다.
    final response = await http.get(url);

    // reponse가 200이 아닐경우 오류 발생
    if (response.statusCode == 200) {
      /// jsonDecode -> String 타입인 rosponse.body를 json으로 변환해준다
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }

      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      /// jsonDecode -> String to Json
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      /// jsonDecode -> String to Json
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return episodesInstances;
    }
    throw Error();
  }
}
