import 'package:newsapp/core/error/exception.dart';

class Failure {
  final ServerException serverException;
  Failure({required this.serverException});
}

class ServerFailure extends Failure {
  ServerFailure({required super.serverException});
}
