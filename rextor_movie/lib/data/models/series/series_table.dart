
import 'package:rextor/data/models/series/series_model.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesTable extends Equatable{
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  SeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview
  });
  @override
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview,
  ];
  factory SeriesTable.fromEntity(SeriesDetail seriesDetail) => SeriesTable(
      id: seriesDetail.id,
      name: seriesDetail.name,
      posterPath: seriesDetail.posterPath,
      overview: seriesDetail.overview
  );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
      id: map["id"],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
  );

  factory SeriesTable.fromDTO(SeriesModel seriesModel) => SeriesTable(
      id: seriesModel.id,
      name: seriesModel.name,
      posterPath: seriesModel.posterPath,
      overview: seriesModel.overview
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Series toEntity() => Series.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    overview: overview,
  );



}