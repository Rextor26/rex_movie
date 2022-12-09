
import 'package:rextor/data/models/series/series_model.dart';
import 'package:equatable/equatable.dart';

class ResponseSeries extends Equatable{
  final List<SeriesModel> seriesList;

  const ResponseSeries({required this.seriesList});
  @override
  List<Object?> get props => [
    seriesList,
  ];
  factory ResponseSeries.fromJson(Map<String, dynamic> json) => ResponseSeries(
    seriesList: List<SeriesModel>.from((json['results'] as List)
        .map((e) => SeriesModel.fromJson(e))
        .where((element) => element.backdropPath != null)
    ),
  );

  Map<String, dynamic> toJson() => {
    'results' : List<dynamic>.from(seriesList.map((e) => e.toJson())),
  };


}