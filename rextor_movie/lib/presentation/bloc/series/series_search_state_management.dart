

import 'package:equatable/equatable.dart';
import 'package:rextor/domain/entities/series/series.dart';

abstract class SearchStateSeries extends Equatable {
  const SearchStateSeries();

  @override
  List<Object> get props => [];
}

class SearchEmptySeries extends SearchStateSeries {}

class SearchLoadingSeries extends SearchStateSeries {}

class SearchErrorSeries extends SearchStateSeries {
  final String message;

  const SearchErrorSeries(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataSeries extends SearchStateSeries {
  final List<Series> result;

  const SearchHasDataSeries(this.result);

  @override
  List<Object> get props => [result];
}
