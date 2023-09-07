

import 'package:cinemapedia/infrastructure/datasource/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) => 
  LocalStorageRepositoryImpl(datasource: IsarDatasource())
);