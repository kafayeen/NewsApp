import 'package:newsapp/core/network/error_msg.dart';

class ServerException implements Exception {
  final ErrorMsg errorMsg;
  ServerException({required this.errorMsg});
}
