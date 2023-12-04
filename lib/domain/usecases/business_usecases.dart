import 'package:dartz/dartz.dart';
import 'package:newsapp/core/base_usecase/base_usecase.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/repository/base_repository.dart';

class BusinessUsecases implements BaseUseCase<List<NewsAppEntites>, NoParams> {
  final BaseRepo baseRepo;
  BusinessUsecases({required this.baseRepo});
  @override
  Future<Either<Failure, List<NewsAppEntites>>> call(NoParams param) async {
    return await baseRepo.getBusiness();
  }
}
