import 'package:equatable/equatable.dart';

abstract class SearchEventSeries extends Equatable {
  const SearchEventSeries();

  @override
  List<Object> get props => [];
}

class OnQueryChangedSeries extends SearchEventSeries {
  final String query;

  const OnQueryChangedSeries(this.query);

  @override
  List<Object> get props => [query];
}
