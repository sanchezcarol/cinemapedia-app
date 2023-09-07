
import 'package:cinemapedia/domain/datasource/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {

  late Future<Isar> db;
  
  IsarDatasource(){
    db = openDB();
  }
  
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if(Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ MovieSchema ], 
        directory: dir.path,
        inspector: true
      );
    }
    return Future.value(Isar.getInstance());
  }


  @override
  Future<List<Movie>> favoritesMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where()
          .offset(offset)
          .limit(limit)
          .findAll();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final movie = await isar.movies
                    .filter()
                    .idEqualTo(movieId)
                    .findFirst();
    return movie != null;
  }

  @override
  Future<void> toggleMovieFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie = await isar.movies
                            .filter()
                            .idEqualTo(movie.id)
                            .findFirst();
    
    if(favoriteMovie != null ) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

}