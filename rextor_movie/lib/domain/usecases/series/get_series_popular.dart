import 'package:dartz/dartz.dart';
import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/series/series.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';

class GetPopularSeries{
  final RepositorySeries repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(){
    return repository.getPopularSeries();
  }
}