import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/usecases/search_usecases.dart';

abstract class BaseRepo {
  Future<Either<Failure, List<NewsAppEntites>>> getBusiness();
  Future<Either<Failure, List<NewsAppEntites>>> getSports();
  Future<Either<Failure, List<NewsAppEntites>>> getSciences();
  Future<Either<Failure, List<NewsAppEntites>>> getSearch(SearchParameter q);
}
