import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeriesDetail{
  final RepositorySeries repository;

  GetSeriesDetail(this.repository);
  Future<Either<Failure, SeriesDetail>> execute(int id){
    return repository.getSeriesDetail(id);
  }
}