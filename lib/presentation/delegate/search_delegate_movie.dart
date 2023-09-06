

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helper/formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future<List<Movie>>Function(String query);


class SearchDelegateMovie extends SearchDelegate<Movie?> {

  List<Movie> initialMovies;
  final SearchMovieCallback searchMovie;
  StreamController<List<Movie>> debouncedMovies =  StreamController.broadcast();
  Timer? _debounceTimer;

  @override
  String get searchFieldLabel => 'Search movie';

  SearchDelegateMovie({required this.searchMovie, this.initialMovies = const []});

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index], 
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            }
          ),
        );
      }
    );
  }

  void _onQueryChanged(String query) {

    if(_debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async { 
      final movies = await searchMovie(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
    });
  }

  void clearStreams(){
    debouncedMovies.close();
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(onPressed: 
            () => query = '', 
            icon: const Icon(Icons.clear)),
        )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: 
    () { clearStreams(); close(context, null);  }, 
    icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final sizes = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: sizes.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
                width: sizes.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( movie.title, style: textStyles.titleMedium ),
      
                    ( movie.overview.length > 100 )
                      ? Text( '${movie.overview.substring(0,100)}...' )
                      : Text( movie.overview ),
      
                    Row(
                      children: [
                        Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                        const SizedBox(width: 5),
                        Text( 
                          Formats.formattedNumber(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900 ),
                        ),
                      ],
                    )
      
                    
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}