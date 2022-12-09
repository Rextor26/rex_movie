import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/series/series_detail.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeriesDetail{
  final RepositorySeries repository;

  GetSeriesDetail(this.repository);
  Future<Either<Failure, SeriesDetail>> execute(int id){
    return repository.getSeriesDetail(id);
  }
}