import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/exception.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/data/data_source/data_source.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/repository/base_repository.dart';
import 'package:newsapp/domain/usecases/search_usecases.dart';

class Repo implements BaseRepo {
  final BaseDataSource baseDataSource;
  Repo({required this.baseDataSource});
  @override
  Future<Either<Failure, List<NewsAppEntites>>> getBusiness() async {
    final result = await baseDataSource.getBusiness();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(serverException: e));
    }
  }

  @override
  Future<Either<Failure, List<NewsAppEntites>>> getSciences() async {
    final result = await baseDataSource.getSciences();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(serverException: e));
    }
  }

  @override
  Future<Either<Failure, List<NewsAppEntites>>> getSearch(
      SearchParameter q) async {
    final result = await baseDataSource.getSearch(q);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(serverException: e));
    }
  }

  @override
  Future<Either<Failure, List<NewsAppEntites>>> getSports() async {
     final result = await baseDataSource.getSports();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(serverException: e));
    }
  }
}
