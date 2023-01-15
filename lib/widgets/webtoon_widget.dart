import 'package:flutter/material.dart';
import 'package:jootoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    /// GestureDetoctor -> 동작 감지를 통해 작동
    return GestureDetector(
      onTap: () {
        // print('take me homeeee');
        /// route -> StatelelessWidget을 애니메이션으로 감싸서 스크린처럼 보일 수 있도록 한다.
        /// MaterialPageRoute -> Navigator.push 이용 시 애니메이션 효과 및 뒤로가기 등 지원
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          /// Hero Widget -> 두 화면 사이에서 발생하는 애니메이션
          Hero(
            tag: id, // Hero widget은 tag가 필수(필수 값으로 태그 구분)
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
