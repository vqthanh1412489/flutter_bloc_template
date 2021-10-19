import 'package:flutter/material.dart';
import 'package:flutter_bloc_learn/src/blocs/movie_detail_bloc.dart';
import 'package:flutter_bloc_learn/src/blocs/movies_bloc.dart';
import 'package:flutter_bloc_learn/src/injection/injection.dart';
import 'package:flutter_bloc_learn/src/models/item_model.dart';
import 'package:flutter_bloc_learn/src/ui/movie_detail.dart';
import 'ui/movie_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == 'movieDetail') {
          final Result result = settings.arguments as Result;
          return MaterialPageRoute(builder: (context) {
            return MovieDetail(
              getIt<MovieDetailBloc>(),
              result.title,
              result.backdropPath,
              result.overview,
              result.releaseDate,
              result.voteAverage,
              result.id,
            );
          });
        }
      },
      routes: {
        '/': (context) => MovieList(
              bloc: getIt<MoviesBloc>(),
            ),
      },
    );
  }
}
