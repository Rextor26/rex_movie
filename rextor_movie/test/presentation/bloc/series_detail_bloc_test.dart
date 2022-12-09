import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/usecases/movie/get_movie_watchlist_status.dart';
import 'package:rextor/domain/usecases/series/get_series_recommendation.dart';
import 'package:rextor/domain/usecases/series/get_series_remove_series_watchlist.dart';
import 'package:rextor/domain/usecases/series/get_series_save_watchlist.dart';
import 'package:rextor/presentation/bloc/series/series_detail_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_detail_event.dart';
import 'package:rextor/presentation/bloc/series/series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rextor/presentation/bloc/series/series_detail_state_management.dart';
import '../../dummy_data/dummy_objects.dart';
import 'series_detail_notifier.mocks.dart';

@GenerateMocks([
  DetailSeriesNotifier,
  GetSeriesRecommendations,
  GetWatchListStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late SeriesDetailBloc detailSeriesBloc;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetSeriesWatchListStatus mockGetSeriesWatchlistStatus;
  late MockSeriesSaveWatchlist mockSeriesSaveWatchlist;
  late MockSeriesRemoveWatchlist mockSeriesRemoveWatchlist;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetSeriesWatchlistStatus = MockGetSeriesWatchListStatus();
    mockSeriesSaveWatchlist = MockSeriesSaveWatchlist();
    mockSeriesRemoveWatchlist = MockSeriesRemoveWatchlist();
    detailSeriesBloc = SeriesDetailBloc(getTvseriesDetail: mockGetSeriesDetail,getWatchListStatus: mockGetSeriesWatchlistStatus,saveWatchlist: mockSeriesSaveWatchlist,removeWatchlist: mockSeriesRemoveWatchlist);
  });

  const tId = 1;


  group('Get Series Series Detail', () {
  test('initial state should be empty', () {
      expect(detailSeriesBloc.state.state, RequestState.Empty);
    });

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));
        return detailSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailById(tId)),
      expect: () => [
        SeriesDetailState.initial().copyWith(state: RequestState.Loading),
        SeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvseriesDetail: testSeriesDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetSeriesDetail.execute(tId));
      },
    );

   blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should execute save watchlist when function called',
      build: () {
        when(mockSeriesSaveWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetSeriesWatchlistStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => true);
        return detailSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
      expect: () => [
        SeriesDetailState.initial().copyWith(
            tvseriesDetail: testSeriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Success'),
        SeriesDetailState.initial().copyWith(
            tvseriesDetail: testSeriesDetail,
            isAddedToWatchlist: true,
            watchlistMessage: 'Success'),
      ],
      verify: (_) {
        verify(mockSeriesSaveWatchlist.execute(testSeriesDetail));
      },
    );
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockSeriesRemoveWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetSeriesWatchlistStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => false);
        return detailSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveSeriesWatchlist(testSeriesDetail)),
      expect: () => [
        SeriesDetailState.initial().copyWith(
            tvseriesDetail: testSeriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed'),
      ],
      verify: (_) {
        verify(mockSeriesRemoveWatchlist.execute(testSeriesDetail));
      },
    );
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSeriesSaveWatchlist.execute(testSeriesDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetSeriesWatchlistStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => false);
        return detailSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
      expect: () => [
        SeriesDetailState.initial().copyWith(
            tvseriesDetail: testSeriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSeriesSaveWatchlist.execute(testSeriesDetail));
      },
    );

      blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(mockSeriesRemoveWatchlist.execute(testSeriesDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetSeriesWatchlistStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => false);
        return detailSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveSeriesWatchlist(testSeriesDetail)),
      expect: () => [
        SeriesDetailState.initial().copyWith(
            tvseriesDetail: testSeriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSeriesRemoveWatchlist.execute(testSeriesDetail));
      },
    );
  
  });
}
