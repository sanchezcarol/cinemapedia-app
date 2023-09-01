

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieProvider)[widget.movieId];
    
    if(movie == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie),
          SliverList(delegate: 
            SliverChildBuilderDelegate((context, index) {
              return _MovieDetails(movie:movie);
            }, childCount: 1)
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final sizes = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, width: sizes.width * 0.3)),
    
              const SizedBox(width: 15),
    
              SizedBox(
                width: sizes.width * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    const SizedBox(height: 10,),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 10),
    
          Wrap(
            children: [
              ...movie.genreIds.map((genre) => 
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                )
            )]
            ),        
          const SizedBox(height: 100,),
    
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.70,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath,
              fit: BoxFit.cover
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.9,1.0]
                  )
                )
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.transparent],
                    begin: Alignment.topLeft,
                    stops: [0.0,0.3]
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}