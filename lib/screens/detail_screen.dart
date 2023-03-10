import 'package:flutter/material.dart';
import 'package:jootoon/models/webtoon_detail_model.dart';
import 'package:jootoon/models/webtoon_episode_model.dart';
import 'package:jootoon/services/api_service.dart';

import '../widgets/episode_widget.dart';

/// getToonById(id) -> parameter id를 받으려면 StatefulWidget으로 변경해야한다.
class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();

    /// id 앞에 widget이 붙는 이유는 상속받은 StatefulWidget인 DetationScreen의 id에 접근하기 위해
    /// StatefulWidget을 통해 State 사용
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),

      /// SingleChildScrollView Widget -> 화면 Overflow를 막아준다.(Scroll Down) body에 감싸준다.
      body: SingleChildScrollView(
        child: Padding(
          /// padding을 통해 간격조절 horizontal : 수평, vertical : 수직
          padding: const EdgeInsets.all(
              50), // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50)
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id, // Hero widget은 tag가 필수(필수 값으로 태그 구분)
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ]),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var episode in snapshot.data!)
                            Episode(
                              episode: episode,
                              webtoonId: widget.id,
                            ),
                        ],
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
