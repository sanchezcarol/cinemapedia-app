import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(); //Llamamos la funcion
    ref.read(popularMoviesProvider.notifier).loadNextPage(); //Llamamos la funcion
    ref.read(topRatedMoviesProvider.notifier).loadNextPage(); //Llamamos la funcion
    ref.read(upcomingMoviesProvider.notifier).loadNextPage(); //Llamamos la funcion

  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(initialLoadingProvider);
    if(loading) return const Loader();
    
    final slideshowMovies = ref.watch(moviesSliderProvider); //obtenemos el estado
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //obtenemos el estado
    final popularMovies = ref.watch(popularMoviesProvider); //obtenemos el estado
    final topRated = ref.watch(topRatedMoviesProvider); //obtenemos el estado
    final upcomingMovies = ref.watch(upcomingMoviesProvider); //obtenemos el estado
    
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.symmetric(horizontal: 0),
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
              children: [
                MoviesSlider(movies: slideshowMovies),
                MoviesHorizontal(
                  movies: nowPlayingMovies, 
                  title: 'En cines', 
                  subtitle: 'Lunes 20',
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
                ),
                MoviesHorizontal(
                  movies: popularMovies, 
                  title: 'Populares', 
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
                ),
                MoviesHorizontal(
                  movies: topRated, 
                  title: 'Top Rated', 
                  loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
                ),
                MoviesHorizontal(
                  movies: upcomingMovies, 
                  title: 'Upcoming', 
                  loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                )
              ],
            );
        }, childCount: 1)),
      ],
    );
  }
}
