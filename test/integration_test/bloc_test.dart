import 'package:flutter_bloc_learn/src/blocs/movies_bloc.dart';
import 'package:flutter_bloc_learn/src/injection/injection.dart';
import 'package:flutter_bloc_learn/src/models/item_model.dart';
import 'package:flutter_test/flutter_test.dart';

// Cái này dùng để check coi api có đúng không thôi.  run 1 lần có thể biết api nào trong app đang bị lỗi.
void main() async {
  configureDependencies();
  group("Home Api TESTING =>", () {
    test("fetchAllMovies", () async {
      var moviesBloc = getIt<MoviesBloc>();
      moviesBloc.init();
      moviesBloc.fetchAllMovies();
      moviesBloc.allMovies.listen(expectAsync1((value) {
        expect(value, isInstanceOf<ItemModel>());
      }));
    });
  });
}
