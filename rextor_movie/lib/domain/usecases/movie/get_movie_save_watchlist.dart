import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/movie/movie_detail.dart';
import 'package:rextor/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
