// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/movie_detail_bloc.dart' as _i7;
import '../blocs/movies_bloc.dart' as _i8;
import '../resources/movie_api_provider.dart' as _i5;
import '../resources/repository.dart' as _i6;
import '../services/dio_config.dart' as _i3;
import '../services/dio_method.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.DioConfig>(_i3.DioConfig());
  gh.singleton<_i4.DioMethod>(_i4.DioMethod(get<_i3.DioConfig>()));
  gh.singleton<_i5.MovieApiProvider>(
      _i5.MovieApiProvider(get<_i4.DioMethod>()));
  gh.singleton<_i6.Repository>(_i6.Repository());
  gh.lazySingleton<_i7.MovieDetailBloc>(
      () => _i7.MovieDetailBloc(get<_i6.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i8.MoviesBloc>(() => _i8.MoviesBloc(get<_i6.Repository>()),
      dispose: (i) => i.dispose());
  return get;
}
