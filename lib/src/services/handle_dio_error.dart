import 'package:dio/dio.dart';
import 'package:flutter_bloc_learn/src/models/error_json.dart';

dynamic handleDioError(DioError dioError) {
  print('Dio error!');
  print('STATUS: ${dioError.response?.statusCode}');
  print('DATA: ${dioError.response?.data}');
  print('HEADERS: ${dioError.response?.headers}');

  if (dioError.response != null) {
    return ErrorJson.fromJson(dioError.response?.data);
  }

  print("Error sending request! ${dioError.message}");

  return ErrorJson(message: dioError.message);
}
