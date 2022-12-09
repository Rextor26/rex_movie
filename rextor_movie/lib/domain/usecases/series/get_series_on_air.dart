import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/series/series.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';


class GetOnTheAirSeries{
  final RepositorySeries repository;

  GetOnTheAirSeries(this.repository);
  Future<Either<Failure, List<Series>>> execute(){
    return repository.getOnTheAirSeries();
  }

}