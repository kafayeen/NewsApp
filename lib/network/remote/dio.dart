import 'package:dio/dio.dart';

//baseurl https://newsapi.org/
//method v2/top-headlines?
//queries country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> get(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }
}
