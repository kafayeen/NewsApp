import 'package:newsapp/domain/entites/newsapp_entites.dart';

class NewsAppModel extends NewsAppEntites {
  NewsAppModel(
      {required super.description,
      required super.publishedAt,
      required super.title,
      required super.url,
      required super.urlToImage});
  factory NewsAppModel.fromJson(Map<String, dynamic> json) {
    return NewsAppModel(
        description: json["description"] ?? "",
        publishedAt: json["publishedAt"],
        title: json["title"],
        url: json["url"],
        urlToImage: json["urlToImage"] ??
            "https://cdn.vox-cdn.com/thumbor/HKFzrtgh7PsjC85Gcogec1BhD8Y=/0x0:3840x2560/1200x628/filters:focal(1920x1280:1921x1281)/cdn.vox-cdn.com/uploads/chorus_asset/file/8954441/9U3A2207__1_.jpg");
  }
}
