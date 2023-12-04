import 'package:newsapp/core/dio_service/dio_service.dart';
import 'package:newsapp/core/error/exception.dart';
import 'package:newsapp/core/network/api_constance.dart';
import 'package:newsapp/core/network/error_msg.dart';
import 'package:newsapp/data/models/newsapp_model.dart';
import 'package:newsapp/domain/usecases/search_usecases.dart';

abstract class BaseDataSource {
  Future<List<NewsAppModel>> getBusiness();
  Future<List<NewsAppModel>> getSports();
  Future<List<NewsAppModel>> getSciences();
  Future<List<NewsAppModel>> getSearch(SearchParameter q);
}

class DataSource implements BaseDataSource {
  @override
  Future<List<NewsAppModel>> getBusiness() async {
    var response = await DioService.get(url: ApiConstance.headlinesUrl, query: {
      "country": "us",
      "category": "business",
      "apiKey": ApiConstance.apiKey,
    });
    if (response.statusCode == 200) {
      return List<NewsAppModel>.from((response.data["articles"] as List)
          .map((e) => NewsAppModel.fromJson(e)));
    } else {
      throw ServerException(errorMsg: ErrorMsg.fromJson(response.data));
    }
  }

  @override
  Future<List<NewsAppModel>> getSciences() async {
    var response = await DioService.get(url: ApiConstance.headlinesUrl, query: {
      "country": "us",
      "category": "sciences",
      "apiKey": ApiConstance.apiKey,
    });
    if (response.statusCode == 200) {
      return List<NewsAppModel>.from((response.data["articles"] as List)
          .map((e) => NewsAppModel.fromJson(e)));
    } else {
      throw ServerException(errorMsg: ErrorMsg.fromJson(response.data));
    }
  }

  @override
  Future<List<NewsAppModel>> getSearch(SearchParameter q) async {
    var response = await DioService.get(url: ApiConstance.headlinesUrl, query: {
      "q": q,
      "apiKey": ApiConstance.apiKey,
    });
    if (response.statusCode == 200) {
      return List<NewsAppModel>.from((response.data["articles"] as List)
          .map((e) => NewsAppModel.fromJson(e)));
    } else {
      throw ServerException(errorMsg: ErrorMsg.fromJson(response.data));
    }
  }

  @override
  Future<List<NewsAppModel>> getSports() async {
    var response = await DioService.get(url: ApiConstance.headlinesUrl, query: {
      "country": "us",
      "category": "sports",
      "apiKey": ApiConstance.apiKey,
    });
    if (response.statusCode == 200) {
      return List<NewsAppModel>.from((response.data["articles"] as List)
          .map((e) => NewsAppModel.fromJson(e)));
    } else {
      throw ServerException(errorMsg: ErrorMsg.fromJson(response.data));
    }
  }
}
