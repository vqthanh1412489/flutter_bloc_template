import 'package:dio/dio.dart';
import 'package:flutter_bloc_learn/src/services/dio_config.dart';
import 'package:flutter_bloc_learn/src/services/handle_dio_error.dart';
// import 'package:flutter_bloc_learn/src/services/key_word_storage_local.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioMethod {
  final DioConfig dioConfig;

  // final box = GetStorage();

  late Dio dio;

  DioMethod(this.dioConfig) {
    dio = dioConfig.dio;

    // String? refreshToken = box.read(KeyWordStorageLocal.REFRESH_TOKEN);

    // if (refreshToken != null) {
    //   dio.options.headers["refresh-token"] = refreshToken;
    // }
  }

  Future<dynamic> apiNetworkGET(
      {required String endPoint,
      Map<String, String>? params,
      int retries = 3}) async {
    print("RETRY! ${(3 - retries)}");
    try {
      var response = await dio.get(
        endPoint,
        queryParameters: params,
      );
      // print("_apiNetworkGET ==> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      final _retryCodes = [408, 500, 502, 503, 504, 522, 524];

      final statusCode = e.response?.statusCode;
      int backoff = 500;

      if (retries > 0 && _retryCodes.contains(statusCode)) {
        Future.delayed(Duration(milliseconds: backoff * 2), () {
          return apiNetworkGET(endPoint: endPoint, retries: retries - 1);
        });
      } else {
        return handleDioError(e);
      }
    }
  }

  Future<dynamic> apiNetworkPOST(
      {required String endPoint,
      Map<String, String>? params,
      required var body}) async {
    try {
      var response = await dio.post(
        endPoint,
        queryParameters: params,
        data: body,
      );
      print("_apiNetworkPOST ==> $response");

      return response.data;
    } on DioError catch (e) {
      return handleDioError(e);
    }
  }

  Future<dynamic> apiNetworkPUT(
      {required String endPoint,
      Map<String, String>? params,
      required var body}) async {
    try {
      var response = await dio.put(
        endPoint,
        queryParameters: params,
      );
      print("_apiNetworkPUT ==> $response");

      return response.data;
    } on DioError catch (e) {
      return handleDioError(e);
    }
  }

  Future<dynamic> apiNetworkDELETE(
      {required String endPoint,
      Map<String, String>? params,
      required var body}) async {
    try {
      var response = await dio.delete(
        endPoint,
        queryParameters: params,
      );
      print("_apiNetworkDELETE ==> $response");

      return response.data;
    } on DioError catch (e) {
      return handleDioError(e);
    }
  }
}
