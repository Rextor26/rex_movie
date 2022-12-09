
// ignore_for_file: must_be_immutable

import 'package:rextor/data/models/movie/movie_genre_model.dart';
import 'package:rextor/data/models/series/season_model.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesDetailResponse extends Equatable {
  List<GenreModel> genres;
  List<SeasonModel> seasons;

  bool adult;
  String backdropPath;
  String firstAirDate;
  String homepage;
  int id;
  bool inProduction;
  String lastAirDate;
  String name;
  dynamic nextEpisodeToAir;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;
  SeriesDetailResponse({

    required this.seasons,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    seasons,
    adult,
    backdropPath,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    lastAirDate,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) => SeriesDetailResponse(
    seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    firstAirDate: json["first_air_date"],
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    lastAirDate: json["last_air_date"],
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "adult": adult,
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate,
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "last_air_date": lastAirDate,
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  SeriesDetail toEntity(){
    return SeriesDetail(

        seasons: seasons.map((e) => e.toEntity()).toList(),
        genres: genres.map((e) => e.toEntity()).toList(),
        adult: adult,
        backdropPath: backdropPath,
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        name: name,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        status: status,
        tagline: tagline,
        type: type,
        voteAverage: voteAverage,
        voteCount: voteCount
    );
  }


}
