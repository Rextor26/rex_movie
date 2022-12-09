import 'package:dartz/dartz.dart';
import 'package:rextor_movie/domain/entities/movie/movie_detail.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';
import 'package:rextor_movie/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
