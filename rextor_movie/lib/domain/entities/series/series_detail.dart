// ignore_for_file: must_be_immutable

import 'package:rextor_movie/domain/entities/movie/genre.dart';
import 'package:rextor_movie/domain/entities/series/season.dart';
import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  List<Genre> genres;
  List<Season> seasons;
  bool adult;
  String backdropPath;
  String homepage;
  int id;
  bool inProduction;
  String name;
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

  SeriesDetail({
    required this.seasons,
    required this.genres,
    required this.adult,
    required this.backdropPath,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.name,
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
    genres,
    adult,
    backdropPath,
    homepage,
    id,
    inProduction,
    name,
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
}
