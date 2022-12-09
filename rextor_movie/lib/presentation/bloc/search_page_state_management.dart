import 'package:equatable/equatable.dart';
import '../../domain/entities/movie/movie.dart';

abstract class SearchStateMovie extends Equatable {
  const SearchStateMovie();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchStateMovie {}

class SearchLoading extends SearchStateMovie {}

class SearchError extends SearchStateMovie {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchStateMovie {
  final List<Movie> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
