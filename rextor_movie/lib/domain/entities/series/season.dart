


// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Season extends Equatable {
  int episodeCount;
  int id;
  String name;
  String overview;
  String? posterPath;
  int seasonNumber;
  Season({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });
  @override
  List<Object?> get props => [
    id,
    episodeCount,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}