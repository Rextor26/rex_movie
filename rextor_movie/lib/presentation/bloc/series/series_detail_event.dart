

import 'package:equatable/equatable.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();
}

class FetchSeriesDetailById extends SeriesDetailEvent {
  final int id;
  const FetchSeriesDetailById(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistSeries extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;

  const AddWatchlistSeries(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}

class RemoveSeriesWatchlist extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;

  const RemoveSeriesWatchlist(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}

class LoadWatchlistStatus extends SeriesDetailEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
