import 'package:dartz/dartz.dart';
import 'package:newsapp/core/base_usecase/base_usecase.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/repository/base_repository.dart';

class SearchUsecases
    implements BaseUseCase<List<NewsAppEntites>, SearchParameter> {
  final BaseRepo baseRepo;
  SearchUsecases({required this.baseRepo});

  @override
  Future<Either<Failure, List<NewsAppEntites>>> call(
      SearchParameter param) async {
    return await baseRepo.getSearch(param);
  }
}

class SearchParameter {
  final String q;
  SearchParameter({required this.q});
}
