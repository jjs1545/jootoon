import 'package:flutter/material.dart';
import 'package:jootoon/models/webtoon_model.dart';
import 'package:jootoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  /// const -> 컴파일 전에 값을 알 수 있는 타입
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),

      /// FutureBuilder -> async/wait(비동기) 처리 대신 사용하는 Widget, Builder -> UI를 그려주는 함수
      body: FutureBuilder(
        future: webtoons, // future: await webtoons -> FutureBuilder가 처리
        /// context -> 부모에게 전달, snapshot -> Future의 상태 파악 가능
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("There is data!");
          }
          return const Text('Loading ...');
        },
      ),
    );
  }
}
