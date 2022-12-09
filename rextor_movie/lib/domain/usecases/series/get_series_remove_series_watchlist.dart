import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/series/series_detail.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistSeries{
  final RepositorySeries repository;
  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail seriesDetail){
    return repository.removeWatchlistSeries(seriesDetail);
  }
}