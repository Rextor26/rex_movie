import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedSeries{
  final RepositorySeries repository;

  GetTopRatedSeries(this.repository);
  Future<Either<Failure, List<Series>>> execute(){
    return repository.getTopRatedSeries();
  }
}