import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rextor/presentation/pages/series/series_top_rated_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvseriesBloc extends MockBloc<SeriesEvent, SeriesStateManagement>
    implements TopratedSeriesBloc {}

class SeriesStateFake extends Fake implements SeriesStateManagement {}

class SeriesEventFake extends Fake implements SeriesEvent {}

void main() {
  late MockTopRatedTvseriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(SeriesEventFake());
    registerFallbackValue(SeriesStateFake());
  });

  setUp(() {
    mockBloc = MockTopRatedTvseriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopratedSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadingDataSeries());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedDataSeries(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const ErrorDataSeries('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyDataSeries());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}
