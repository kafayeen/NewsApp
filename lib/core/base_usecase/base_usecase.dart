import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';

abstract class BaseUseCase<T, Param> {
  Future<Either<Failure, T>> call(Param param);
}

class NoParams {
  NoParams();
}
