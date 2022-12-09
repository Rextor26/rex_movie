
import 'package:equatable/equatable.dart';



abstract class SeriesEvent extends Equatable {
  const SeriesEvent();
}

class FetchTvseriesData extends SeriesEvent {
  const FetchTvseriesData();

  @override
  List<Object> get props => [];
}

class FetchTvseriesDataWithId extends SeriesEvent {
  final int id;
  const FetchTvseriesDataWithId(this.id);

  @override
  List<Object> get props => [id];
}
