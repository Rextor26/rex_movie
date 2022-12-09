import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/usecases/series/get_series_watchlist.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_watchlist_bloc_mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistSeriesBloc provider;
  late MockGetWatchlistSeries mockGetWatchlistSeries;


  setUp(() {

    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistSeriesBloc(mockGetWatchlistSeries);

  });

  test('initial state should be empty', () {
    expect(provider.state, EmptyDataSeries());
  });

  blocTest<WatchlistSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right([testWatchlistSeries]));
      return provider;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      LoadedDataSeries([testWatchlistSeries]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return provider;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      const ErrorDataSeries('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistSeries.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return provider;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      const ErrorDataSeries('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistSeries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return provider;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      const ErrorDataSeries('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );
}
