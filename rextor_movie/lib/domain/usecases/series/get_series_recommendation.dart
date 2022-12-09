import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/repositories/series_repository.dart';

class GetSeriesRecommendations{
  final RepositorySeries repository;

  GetSeriesRecommendations(this.repository);
  Future<Either<Failure, List<Series>>> execute(id){
    return repository.getSeriesRecommendations(id);
  }

}
