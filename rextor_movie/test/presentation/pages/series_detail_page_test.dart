import 'package:bloc_test/bloc_test.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_detail_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_detail_event.dart';
import 'package:rextor/presentation/bloc/series/series_detail_state_management.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';
import 'package:rextor/presentation/pages/series/series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvseriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class seriesStateFake extends Fake implements SeriesDetailState {}

class seriesEventFake extends Fake implements SeriesEvent {}

class MockRecommendationSeriesBloc
    extends MockBloc<SeriesEvent, SeriesStateManagement>
    implements RecommendationTvseriesBloc {}

void main() {
  late MockTvseriesDetailBloc mockBloc;
  late MockRecommendationSeriesBloc mockBlocRecom;

  setUpAll(() {
    registerFallbackValue(seriesEventFake());
    registerFallbackValue(seriesStateFake());
  });

  setUp(() {
    mockBloc = MockTvseriesDetailBloc();
    mockBlocRecom = MockRecommendationSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeriesDetailBloc>.value(value: mockBloc),
        BlocProvider<RecommendationTvseriesBloc>.value(value: mockBlocRecom),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(' Page should display Progressbar when tvseriesdetail loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        SeriesDetailState.initial().copyWith(state: RequestState.Loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display Progressbar when recommendation loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(SeriesDetailState.initial().copyWith(
      state: RequestState.Loaded,
      isAddedToWatchlist: false,
      tvseriesDetail: testSeriesDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadingDataSeries());

    final progressBarFinder = find.byType(CircularProgressIndicator).first;

    await tester
        .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(SeriesDetailState.initial().copyWith(
      state: RequestState.Loaded,
      isAddedToWatchlist: false,
      tvseriesDetail: testSeriesDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedDataSeries(testSeriesList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when Tvseries is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(SeriesDetailState.initial().copyWith(
      state: RequestState.Loaded,
      tvseriesDetail: testSeriesDetail,
      isAddedToWatchlist: true,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedDataSeries(testSeriesList));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
