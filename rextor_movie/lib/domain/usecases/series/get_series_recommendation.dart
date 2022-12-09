import 'package:dartz/dartz.dart';
import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/series/series.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';

class GetSeriesRecommendations{
  final RepositorySeries repository;

  GetSeriesRecommendations(this.repository);
  Future<Either<Failure, List<Series>>> execute(id){
    return repository.getSeriesRecommendations(id);
  }

}
