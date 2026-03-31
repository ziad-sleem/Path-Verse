import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@module
abstract class DioModule {
  // register Dio as a singleton
  @lazySingleton
  Dio get dio => Dio();
}