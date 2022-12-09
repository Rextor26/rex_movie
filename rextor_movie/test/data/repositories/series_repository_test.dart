import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rextor/common/exception.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/data/models/movie/movie_genre_model.dart';
import 'package:rextor/data/models/series/series_detail_model.dart';
import 'package:rextor/data/models/series/series_model.dart';
import 'package:rextor/data/repositories/series_repository_impl.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late RepositorySeriesImpl seriesRepository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockSeriesLocalDataSource mockSeriesLocalDataSource;  

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockSeriesLocalDataSource = MockSeriesLocalDataSource();    
    seriesRepository = RepositorySeriesImpl(
        remoteDataSource: mockRemoteDataSource,
        seriesLocalDataSource: mockSeriesLocalDataSource,
    );
  });

  final seriesModel = SeriesModel(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765
  );

  final series = Series(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765
  );

  final seriesModelList = <SeriesModel>[seriesModel];
  final seriesList = <Series>[series];


  group('Get Movie Recommendations', () {
    final tSeriesList = <SeriesModel>[];
    final tId = 1;

    test('should return data when the call is successful', () async {
      /// arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId)).thenAnswer((_) async => tSeriesList);
      /// act
      final result = await seriesRepository.getSeriesRecommendations(tId);
      /// assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(ServerFailure(''));
      // act
      final result = await seriesRepository.getSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed connect to network'));
      // act
      final result = await seriesRepository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect( 
        result, 
        Left(ConnectionFailure('Failed connect to network'))
      );
    });


  });

  group('Popular Series Series', (){
    test('should return list Series series when call to data source is success', () async{
      when(mockRemoteDataSource.getPopularSeries()).thenAnswer((_) async => seriesModelList);
      final result = await seriesRepository.getPopularSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getPopularSeries()).thenThrow(ServerException());
      final result = await seriesRepository.getPopularSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await seriesRepository.getPopularSeries();
      // assert
      verify(mockRemoteDataSource.getPopularSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Top Rated Series Series', (){
    test('should return list Series series when call to data source is success', () async{
      when(mockRemoteDataSource.getTopRatedSeries()).thenAnswer((_) async => seriesModelList);
      final result = await seriesRepository.getTopRatedSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getTopRatedSeries()).thenThrow(ServerException());
      final result = await seriesRepository.getTopRatedSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await seriesRepository.getTopRatedSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Airing Today Series Series', (){
    test('should return list Series series when call to data source is success', () async{
      when(mockRemoteDataSource.getAiringTodaySeries()).thenAnswer((_) async => seriesModelList);
      final result = await seriesRepository.getAiringTodaySeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getAiringTodaySeries()).thenThrow(ServerException());
      final result = await seriesRepository.getAiringTodaySeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodaySeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await seriesRepository.getAiringTodaySeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodaySeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('On The Air Series Series', (){
    test('should return list Series series  when call to data source is success', () async{
      when(mockRemoteDataSource.getOnTheAirSeries()).thenAnswer((_) async => seriesModelList);
      final result = await seriesRepository.getOnTheAirSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getOnTheAirSeries()).thenThrow(ServerException());
      final result = await seriesRepository.getOnTheAirSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await seriesRepository.getOnTheAirSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Search Series Series', (){
    final tQuery = 'pasion';

    test('should return list Series series  when call to data source is success', () async{
      when(mockRemoteDataSource.searchSeries(tQuery)).thenAnswer((_) async => seriesModelList);      
      final result = await seriesRepository.searchSeries(tQuery);      
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.searchSeries(tQuery)).thenThrow(ServerException());
      final result = await seriesRepository.searchSeries(tQuery);
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {      
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect the network'));
      final result = await seriesRepository.searchSeries(tQuery);
      verify(mockRemoteDataSource.searchSeries(tQuery));
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });

  });

  group('Save watchlist Series Series', (){

    test('should return success message when saving successful', () async{
      when(mockSeriesLocalDataSource.insertSeriesWatchlist(testSeriesTable)).thenAnswer((_) async => "Added to watchlist");
      final result = await seriesRepository.saveWatchlistSeries(testSeriesDetail);
      expect(result, Right('Added to watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      when(mockSeriesLocalDataSource.insertSeriesWatchlist(testSeriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await seriesRepository.saveWatchlistSeries(testSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist Series Series', (){

    test('should return success message when remove successful', () async{
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable)).thenAnswer((_) async => "Removed from watchlist");
      final result = await seriesRepository.removeWatchlistSeries(testSeriesDetail);
      expect(result, Right('Removed from watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await seriesRepository.removeWatchlistSeries(testSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status Series Series', (){
    test('should return watch status weather data is found', () async{
      final tId = 1;
      when(mockSeriesLocalDataSource.getSeriesById(tId)).thenAnswer((_) async => null);
      final result = await seriesRepository.isAddedToWatchlistSeries(tId);
      expect(result, false);
    });
  });

  group('Get watchlist Series Series', (){
    test('should return list of movies', () async{
      when(mockSeriesLocalDataSource.getWatchlistSeries()).thenAnswer((_) async => [testSeriesTable]);
      final result = await seriesRepository.getWatchlistSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });
  });

  group('Get Series Series Detail', () {
    final tId = 1;
    final responseSeries = SeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',      
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: '',
      id: 1,      
      originalLanguage: '',      
      overview: 'overview',
      popularity: 0.0,
      posterPath: 'posterPath',            
      status: '',
      tagline: '',            
      voteAverage: 0,
      voteCount: 0, 
      firstAirDate: 'firstAirDate', 
      inProduction: false, 
      lastAirDate: 'lastAirDate', 
      name: 'name', 
      nextEpisodeToAir: null, 
      numberOfEpisodes: 0, 
      numberOfSeasons: 0, 
      originalName: '', 
      seasons: [], 
      type: '',

      
    );

    test(
        'should return Series series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenAnswer((_) async => responseSeries);
      // act
      final result = await seriesRepository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await seriesRepository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(SocketException('Failed connect to network'));
      // act
      final result = await seriesRepository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed connect to network'))));
    });
  });

}