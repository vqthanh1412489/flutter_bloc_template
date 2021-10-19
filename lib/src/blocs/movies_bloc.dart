import 'package:flutter_bloc_learn/src/models/item_model.dart';
import 'package:flutter_bloc_learn/src/models/state.dart';
import 'package:flutter_bloc_learn/src/resources/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class MoviesBloc {
  final Repository _repository;
  PublishSubject<ItemModel>? _moviesFetcher;

  MoviesBloc(this._repository);

  init() {
    _moviesFetcher = PublishSubject<ItemModel>();
  }

  @disposeMethod
  dispose() {
    _moviesFetcher?.close();
  }

  Stream<ItemModel> get allMovies => _moviesFetcher!.stream;

  Future<void> fetchAllMovies() async {
    State state = await _repository.fetchAllMovies();
    if (state is SuccessState) {
      _moviesFetcher?.sink.add(state.value);
    } else if (state is ErrorState) {
      _moviesFetcher?.addError(state.msg);
    }
  }
}
