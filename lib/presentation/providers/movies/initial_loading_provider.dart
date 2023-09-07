

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider((ref) {
  
  final nowPlaying = ref.watch(nowPlayingMoviesProvider).isEmpty; 
  final popular= ref.watch(popularMoviesProvider).isEmpty; 
  final topRated = ref.watch(topRatedMoviesProvider).isEmpty; 
  final upcoming = ref.watch(upcomingMoviesProvider).isEmpty; 

  if(nowPlaying || popular || topRated  || upcoming ) return true;
  return false;
});