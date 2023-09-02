

import 'package:cinemapedia/infrastructure/datasource/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Repositorio inmutable // provider de solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
