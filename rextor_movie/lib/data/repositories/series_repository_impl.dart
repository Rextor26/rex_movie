


import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/exception.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/data/datasources/series_local_data_source.dart';
import 'package:rextor/data/datasources/remote_data_source.dart';
import 'package:rextor/data/models/series/series_table.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/repositories/series_repository.dart';

class RepositorySeriesImpl implements RepositorySeries{
  final RemoteDataSource remoteDataSource;

  final SeriesLocalDataSource seriesLocalDataSource;
  RepositorySeriesImpl({
    required this.remoteDataSource,
    required this.seriesLocalDataSource
  });


  @override
  Future<Either<Failure, List<Series>>> searchSeries(String query) async {

    try{
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getAiringTodaySeries() async{
    try{
      final result = await remoteDataSource.getAiringTodaySeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getOnTheAirSeries() async{
    try{
      final result = await remoteDataSource.getOnTheAirSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getPopularSeries() async {
    try{
      final result = await remoteDataSource.getPopularSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getTopRatedSeries() async{
    try{
      final result = await remoteDataSource.getTopRatedSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }
  @override
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id) async {
    try{
      final result = await remoteDataSource.getSeriesDetail(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }

  }

  @override
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id) async{
    try{
      final result = await remoteDataSource.getSeriesRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerFailure{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }on TlsException{
      return const Left(SSLFailure("Gagal Terverifikasi"));
    }
  }
  @override
  Future<bool> isAddedToWatchlistSeries(int id) async{

    final result = await seriesLocalDataSource.getSeriesById(id);
    return result != null;
  }
  @override
  Future<Either<Failure, List<Series>>> getWatchlistSeries() async{
    final result = await seriesLocalDataSource.getWatchlistSeries();
    return Right(result.map((e) => e.toEntity()).toList());
  }


  @override
  Future<Either<Failure, String>> removeWatchlistSeries(SeriesDetail seriesDetail) async{

    try{
      final result = await seriesLocalDataSource.removeWatchlistSeries(SeriesTable.fromEntity(seriesDetail));
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail seriesDetail) async{
    try{
      final result = await seriesLocalDataSource.insertSeriesWatchlist(SeriesTable.fromEntity(seriesDetail));
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }catch(e){
      throw e;
    }
  }

}