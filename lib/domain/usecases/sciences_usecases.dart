import 'package:dartz/dartz.dart';
import 'package:newsapp/core/base_usecase/base_usecase.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/repository/base_repository.dart';

class SciencesUsecases implements BaseUseCase<List<NewsAppEntites>, NoParams> {
  final BaseRepo baseRepo;
  SciencesUsecases({required this.baseRepo});
  @override
  Future<Either<Failure, List<NewsAppEntites>>> call(NoParams noParams) async {
    return await baseRepo.getSciences();
  }
}
