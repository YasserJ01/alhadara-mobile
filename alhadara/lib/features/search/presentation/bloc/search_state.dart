import 'package:equatable/equatable.dart';
import '../../domain/entities/search_filters.dart';
import '../../domain/entities/search_result.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResult result;
  final String query;
  final SearchFilters? filters;

  const SearchLoaded({
    required this.result,
    required this.query,
    this.filters,
  });

  @override
  List<Object?> get props => [result, query, filters];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty({required this.query});

  @override
  List<Object> get props => [query];
}
