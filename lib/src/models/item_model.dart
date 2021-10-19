import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    required this.results,
    required this.page,
    required this.totalResults,
    required this.totalPages,
  });

  final List<Result> results;
  final int page;
  final int totalResults;
  final int totalPages;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Result {
  Result({
    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  final int voteCount;
  final int id;
  final bool video;
  final dynamic voteAverage;
  final String title;
  final double popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        voteCount: json["vote_count"],
        id: json["id"],
        video: json["video"],
        voteAverage: json["vote_average"],
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath: json["backdrop_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: json["release_date"],
      );

  Map<String, dynamic> toJson() => {
        "vote_count": voteCount,
        "id": id,
        "video": video,
        "vote_average": voteAverage,
        "title": title,
        "popularity": popularity,
        "poster_path": posterPath,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "backdrop_path": backdropPath,
        "adult": adult,
        "overview": overview,
        "release_date": releaseDate,
      };
}
