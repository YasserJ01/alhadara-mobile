import 'package:equatable/equatable.dart';

import '../../domain/entities/search_filters.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchCoursesEvent extends SearchEvent {
  final String query;
  final SearchFilters? filters;

  const SearchCoursesEvent({
    required this.query,
    this.filters,
  });

  @override
  List<Object?> get props => [query, filters];
}

class ClearSearchEvent extends SearchEvent {}

class UpdateFiltersEvent extends SearchEvent {
  final SearchFilters filters;

  const UpdateFiltersEvent({required this.filters});

  @override
  List<Object> get props => [filters];
}
