import 'package:dartz/dartz.dart';
import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/movie/movie_detail.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';

class RemovedWatchlist {
  final MovieRepository repository;

  RemovedWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
