import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movie/movie_tmdb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieTMDB movie) => Movie(
      adult: movie.adult,
      backdropPath: movie.backdropPath != '' 
        ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
        : 'https://ih1.redbubble.net/image.4786164839.8625/st,small,845x845-pad,1000x1000,f8f8f8.jpg'
      ,
      genreIds: movie.genreIds.map((e) => e.toString()).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: movie.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
        : 'no-poster'
      ,
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);
}
