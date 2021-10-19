import 'dart:async';
import 'package:flutter_bloc_learn/src/models/error_json.dart';
import 'package:flutter_bloc_learn/src/models/trailer_model.dart';
import 'package:flutter_bloc_learn/src/models/state.dart';
import 'package:flutter_bloc_learn/src/services/dio_method.dart';
import 'package:injectable/injectable.dart';

import '../models/item_model.dart';

@singleton
class MovieApiProvider {
  final String _apiKey = '00563e29a1959063f34f277c4f5da5a3';

  final DioMethod dioMethod;

  MovieApiProvider(this.dioMethod);

  Future<State> fetchMovieList() async {
    var response =
        await dioMethod.apiNetworkGET(endPoint: "poxular?api_key=$_apiKey");

    if (response is Map<String, dynamic>) {
      return State<ItemModel>.success(ItemModel.fromJson(response));
    } else if (response is ErrorJson) {
      return State<String>.error(response.message);
    } else {
      return State<String>.error(response.toString());
    }
  }

  Future<State> fetchTrailer(int movieId) async {
    var response = await dioMethod.apiNetworkGET(
        endPoint: '$movieId/videos?api_key=$_apiKey');

    if (response is Map<String, dynamic>) {
      return State<TrailerModel>.success(TrailerModel.fromJson(response));
    } else if (response is ErrorJson) {
      return State<String>.error(response.message);
    } else {
      return State<String>.error(response.toString());
    }
  }
}
