

import 'package:cinemapedia/presentation/delegate/search_delegate_movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(children: [
            Icon(Icons.movie_filter_sharp, color: colors.primary),
            const SizedBox(width: 5,),
            Text('Cinemapedia', style: titleMedium),

            const Spacer(),
            IconButton(onPressed: (){
              final searchQuery = ref.read(searchQueryProvider);
              showSearch(
                query: searchQuery,
                context: context, 
                delegate: SearchDelegateMovie(
                  initialMovies: ref.read(searchedMoviesProvider),
                  searchMovie: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                )
              ).then((movie) {
                if(movie == null) return;
                context.push('/home/0/movie/${movie.id}');
              });
            }, icon: const Icon(Icons.search))
          ]),
        ),
      )
    );
  }
}