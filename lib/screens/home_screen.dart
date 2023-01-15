import 'package:flutter/material.dart';
import 'package:jootoon/models/webtoon_model.dart';
import 'package:jootoon/services/api_service.dart';
import 'package:jootoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  /// const -> 컴파일 전에 값을 알 수 있는 타입
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            /// 많은 양의 데이터를 보여주고 싶을 때 -> ListView
            // return ListView(
            //   children: [
            //     /// ! -> dart에게 데이터가 있다는 것을 확신시켜 준다.
            //     for (var webtoon in snapshot.data!) Text(webtoon.title)
            //   ],
            // );
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(
                    snapshot,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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

      /// 아이템 렌더
      itemBuilder: (context, index) {
        // print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },

      /// separatorBuilder -> 리스트 아이템 사이 렌더(구분용)
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
