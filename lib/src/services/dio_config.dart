import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioConfig {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://api.themoviedb.org/3/movie/',
    connectTimeout: 5000,
    receiveTimeout: 100000,
    headers: {
      HttpHeaders.userAgentHeader: "dio",
      "api": "1.0.0",
    },
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  ));
}
