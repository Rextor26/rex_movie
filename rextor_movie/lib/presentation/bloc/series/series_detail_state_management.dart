import 'package:equatable/equatable.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';

class SeriesDetailState extends Equatable {
  final SeriesDetail? tvseriesDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final RequestState state;

  const SeriesDetailState({
    required this.tvseriesDetail,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.state,
  });

  SeriesDetailState copyWith({
    SeriesDetail? tvseriesDetail,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    RequestState? state,
  }) {
    return SeriesDetailState(
      tvseriesDetail: tvseriesDetail ?? this.tvseriesDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory SeriesDetailState.initial() {
    return const SeriesDetailState(
      tvseriesDetail: null,
      watchlistMessage: '',
      isAddedToWatchlist: false,
      state: RequestState.Empty
    );
  }

  @override
  List<Object> get props => [
        watchlistMessage,
        isAddedToWatchlist,
        state,
      ];
}
