
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasource/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movies_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movie/list_moviedb_response.dart';
import 'package:cinemapedia/infrastructure/models/movie/movie_details.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
        'lenguage': 'es-MX'
      }
    )
  );

  List<Movie> jsonToMovies( Map<String,dynamic> json ) {
    final movieResponse = ListMovieDbResponse.fromJson(json);
    final List<Movie> movie = 
    movieResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-post')
      .map((movie) => MovieMapper.movieDBToEntity(movie)).toList();

    return movie;

  }
 
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );
    return jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', 
      queryParameters: {
        'page': page
      }
    );
    return jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', 
      queryParameters: {
        'page': page
      }
    );
    return jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );
    return jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if(response.statusCode != 200) throw Exception('Movie with id: $id not found');
    final movie = MovieDetails.fromJson(response.data);
    return MovieMapper.movieDetailsToEntity(movie);
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if(query.isEmpty) return [];

    final response = await dio.get('/search/movie', 
      queryParameters: {
        'query': query
      }
    );
    return jsonToMovies(response.data);
  }





}