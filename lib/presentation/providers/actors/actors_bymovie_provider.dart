
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsNotifier, Map<String,List<Actor>>>((ref) {

  return ActorsNotifier(
    getActorsByMovie: ref.watch(actorsRepositoryProvider).getActorsByMovie
  );
});

typedef GetActorsCallback = Future<List<Actor>>Function(String id);

class ActorsNotifier extends StateNotifier<Map<String,List<Actor>>> {
  
  final GetActorsCallback getActorsByMovie ;
  
  ActorsNotifier({required this.getActorsByMovie}):super({});

  Future<void> loadActors(String id) async {

    if(state[id] != null ) return;
    final actors = await getActorsByMovie(id);
    state = {...state, id: actors};
  }


}