

import 'package:cinemapedia/infrastructure/datasource/actor_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource:ActorDatasource());
});