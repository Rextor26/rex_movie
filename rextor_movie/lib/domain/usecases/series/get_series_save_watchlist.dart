import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistSeries{
  final RepositorySeries repository;
  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail seriesDetail){
    return repository.saveWatchlistSeries(seriesDetail);
  }
}