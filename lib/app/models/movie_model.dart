
//     final movieDataModel = movieDataModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MovieDataModel movieDataModelFromJson(String str) =>
    MovieDataModel.fromJson(json.decode(str));

class MovieDataModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieDataModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) => MovieDataModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Result {
  bool adult;
  String backdropPath;
  int id;
  String title;

  String originalTitle;
  String overview;
  String posterPath;

  List<int> genreIds;
  double popularity;
  DateTime releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "", 
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "", 
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 0.0, 
        releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : DateTime.now(), 
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0, 
        voteCount: json["vote_count"],
      );
      Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      // Add other properties that you want to include in the JSON representation
    };
  }
}
