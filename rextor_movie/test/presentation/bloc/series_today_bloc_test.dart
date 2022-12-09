import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/usecases/series/get_series_Today.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_list_bloc.mocks.dart';

@GenerateMocks([GetAiringTodaySeries])
void main() {
  late MockGetSeriesAiringToday mockGetTodaySeries;
  late SeriesTodayBloc todaySeriesBloc;

  setUp(() {
    mockGetTodaySeries = MockGetSeriesAiringToday();
    todaySeriesBloc = SeriesTodayBloc(mockGetTodaySeries);
  });

  test('initial state should be empty', () {
    expect(todaySeriesBloc.state, EmptyDataSeries());
  });


    blocTest<SeriesTodayBloc, SeriesStateManagement>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTodaySeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return todaySeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      LoadedDataSeries(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTodaySeries.execute());
    },
  );

  blocTest<SeriesTodayBloc, SeriesStateManagement>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetTodaySeries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return todaySeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      const ErrorDataSeries('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTodaySeries.execute());
    },
  );
}
