import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';

abstract class RepositorySeries{
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getAiringTodaySeries();
  Future<Either<Failure, List<Series>>> getOnTheAirSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail seriesDetail);
  Future<Either<Failure, String>> removeWatchlistSeries(SeriesDetail seriesDetail);
  Future<bool> isAddedToWatchlistSeries(int id);
  Future<Either<Failure, List<Series>>> getWatchlistSeries();
}