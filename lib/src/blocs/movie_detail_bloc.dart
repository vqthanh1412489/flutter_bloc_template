import 'package:flutter_bloc_learn/src/models/state.dart';
import 'package:flutter_bloc_learn/src/models/trailer_model.dart';
import 'package:flutter_bloc_learn/src/resources/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class MovieDetailBloc {
  final Repository _repository;
  BehaviorSubject<TrailerModel>? _trailers;

  MovieDetailBloc(this._repository);

  init() {
    print("MovieDetailBloc init");
    _trailers = BehaviorSubject<TrailerModel>();
  }

  @disposeMethod
  dispose() async {
    await _trailers?.drain();
    _trailers?.close();
  }

  Stream<TrailerModel> get movieTrailers => _trailers!.stream;

  void fetchTrailersById(id) async {
    final state = await _repository.fetchTrailers(id);
    if (state is SuccessState) {
      _trailers?.sink.add(state.value);
    } else {
      _trailers?.addError((state as ErrorState).msg);
    }
  }
}
