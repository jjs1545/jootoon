class WebtoonModel {
  final String title, thumb, id;

  /// named Constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)

      /// Map -> String key(JSON key), dynamic value(Json body)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
