import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class SearchSeries{
  final RepositorySeries repository;
  SearchSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query){
    return repository.searchSeries(query);
  }
}