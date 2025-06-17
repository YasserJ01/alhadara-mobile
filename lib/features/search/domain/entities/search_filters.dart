// lib/features/search/domain/entities/search_filters.dart
import 'package:equatable/equatable.dart';

class SearchFilters extends Equatable {
  final String? category;
  final bool? certificationEligible;
  final double? maxPrice;
  final double? minPrice;
  final String? models;

  const SearchFilters({
    this.category,
    this.certificationEligible,
    this.maxPrice,
    this.minPrice,
    this.models,
  });

  SearchFilters copyWith({
    String? category,
    bool? certificationEligible,
    double? maxPrice,
    double? minPrice,
    String? models,
  }) {
    return SearchFilters(
      category: category ?? this.category,
      certificationEligible: certificationEligible ?? this.certificationEligible,
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      models: models ?? this.models,
    );
  }

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};

    if (category != null) params['category'] = category;
    if (certificationEligible != null) params['certification_eligible'] = certificationEligible.toString();
    if (maxPrice != null) params['max_price'] = maxPrice.toString();
    if (minPrice != null) params['min_price'] = minPrice.toString();
    if (models != null) params['models'] = models;

    return params;
  }

  @override
  List<Object?> get props => [category, certificationEligible, maxPrice, minPrice, models];
}
