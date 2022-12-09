import 'package:equatable/equatable.dart';
import 'package:rextor/domain/entities/series/series.dart';

abstract class SeriesStateManagement extends Equatable {
  const SeriesStateManagement();

  @override
  List<Object> get props => [];

}

class EmptyDataSeries extends SeriesStateManagement {}

class LoadingDataSeries extends SeriesStateManagement {}

class ErrorDataSeries extends SeriesStateManagement {
  final String message;

  const ErrorDataSeries(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedDataSeries extends SeriesStateManagement {
  final List<Series> result;

  const LoadedDataSeries(this.result);

  @override
  List<Object> get props => [result];
}
