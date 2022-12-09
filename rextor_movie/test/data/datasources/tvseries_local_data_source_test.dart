import 'package:rextor/common/exception.dart';
import 'package:rextor/data/datasources/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseSeriesHelper mockDatabaseSeriesHelper;

  setUp((){
    mockDatabaseSeriesHelper = MockDatabaseSeriesHelper();
    dataSource = SeriesLocalDataSourceImpl(databaseHelperSeries: mockDatabaseSeriesHelper);
  });

  group('Save watchlist Series series', (){
    test('should return success message wen insert to database is successful', () async{
      /// arrange
      when(mockDatabaseSeriesHelper.insertSeriesWatchlist(testSeriesTable))
          .thenAnswer((_) async => 1);
      /// act
      final result = await dataSource.insertSeriesWatchlist(testSeriesTable);
      /// assert
      expect(result, 'Added to watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseSeriesHelper.insertSeriesWatchlist(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertSeriesWatchlist(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.removeWatchList(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(result, 'Remove from watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.removeWatchList(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series Series Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Series series', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}