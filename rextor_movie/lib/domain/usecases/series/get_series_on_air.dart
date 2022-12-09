import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';


class GetOnTheAirSeries{
  final RepositorySeries repository;

  GetOnTheAirSeries(this.repository);
  Future<Either<Failure, List<Series>>> execute(){
    return repository.getOnTheAirSeries();
  }

}