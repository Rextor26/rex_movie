import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/movie/movie.dart';
import 'package:rextor/domain/repositories/movie_repository.dart';
import 'package:rextor/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
