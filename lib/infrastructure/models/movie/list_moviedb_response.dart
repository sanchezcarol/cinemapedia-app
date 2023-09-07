import 'package:cinemapedia/infrastructure/models/movie/list_movie_tmdb.dart';

class ListMovieDbResponse {
    final Dates? dates;
    final int page;
    final List<ListMovieTMDB> results;
    final int totalPages;
    final int totalResults;

    ListMovieDbResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory ListMovieDbResponse.fromJson(Map<String, dynamic> json) => ListMovieDbResponse(
        dates: (json["dates"] != null) ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<ListMovieTMDB>.from(json["results"].map((result) => ListMovieTMDB.fromJson(result))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    final DateTime maximum;
    final DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}