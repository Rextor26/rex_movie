import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/repositories/series_repository.dart';

class GetPopularSeries{
  final RepositorySeries repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(){
    return repository.getPopularSeries();
  }
}