import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(); //Llamamos la funcion
  }

  @override
  Widget build(BuildContext context) {
    final slideshowMovies = ref.watch(moviesSliderProvider); //obtenemos el estado
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //obtenemos el estado

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlider(movies: slideshowMovies),
        MoviesHorizontal(
          movies: nowPlayingMovies, 
          title: 'En cines', 
          subtitle: 'Lunes 20',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
        )
      ],
    );
  }
}
