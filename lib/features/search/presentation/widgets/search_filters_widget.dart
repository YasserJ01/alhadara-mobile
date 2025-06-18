// lib/features/search/presentation/widgets/search_filters_widget.dart
import 'package:flutter/material.dart';
import '../../domain/entities/search_filters.dart';
import '../bloc/search_bloc.dart';

class SearchFiltersWidget extends StatefulWidget {
  final SearchBloc searchBloc; // Add SearchBloc parameter
  final Function(SearchFilters) onApplyFilters;

  const SearchFiltersWidget({
    super.key,
    required this.searchBloc, // Make it required
    required this.onApplyFilters,
  });

  @override
  State<SearchFiltersWidget> createState() => _SearchFiltersWidgetState();
}

class _SearchFiltersWidgetState extends State<SearchFiltersWidget> {
  String? _selectedCategory;
  bool? _certificationEligible;
  double? _minPrice;
  double? _maxPrice;
  String? _selectedModels;

  final List<String> _categories = ['course', 'workshop'];
  final List<String> _models = ['departments', 'course_types', 'courses'];
  final List<String> _selectedModelsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle Bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Search Filters',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: _clearAllFilters,
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Category Filter
                _buildFilterSection(
                  title: 'Category',
                  child: Row(
                    children: _categories.map((category) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = _selectedCategory == category
                                  ? null
                                  : category;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedCategory == category
                                  ? Colors.blue[100]
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedCategory == category
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              category.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedCategory == category
                                    ? Colors.blue[800]
                                    : Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Certification Filter
                _buildFilterSection(
                  title: 'Certification Eligible',
                  child: Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text('Certification Available'),
                          value: _certificationEligible ?? false,
                          onChanged: (value) {
                            setState(() {
                              _certificationEligible =
                                  value == true ? true : null;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Price Range Filter
                _buildFilterSection(
                  title: 'Price Range',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Min Price',
                                prefixText: '\$',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                _minPrice = double.tryParse(value);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Max Price',
                                prefixText: '\$',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                _maxPrice = double.tryParse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Search Models Filter
                _buildFilterSection(
                  title: 'Search In',
                  child: Column(
                    children: _models.map((model) {
                      return CheckboxListTile(
                        title: Text(_getModelDisplayName(model)),
                        subtitle: Text(_getModelDescription(model)),
                        value: _selectedModelsList.contains(model),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _selectedModelsList.add(model);
                            } else {
                              _selectedModelsList.remove(model);
                            }
                            _selectedModels = _selectedModelsList.join(', ');
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 32),

                // Apply Filters Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  String _getModelDisplayName(String model) {
    switch (model) {
      case 'departments':
        return 'Departments';
      case 'course_types':
        return 'Course Types';
      case 'courses':
        return 'Courses';
      default:
        return model;
    }
  }

  String _getModelDescription(String model) {
    switch (model) {
      case 'departments':
        return 'Search in department names and descriptions';
      case 'course_types':
        return 'Search in course type categories';
      case 'courses':
        return 'Search in course titles and descriptions';
      default:
        return '';
    }
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = null;
      _certificationEligible = null;
      _minPrice = null;
      _maxPrice = null;
      _selectedModels = null;
      _selectedModelsList.clear();
    });
  }

  void _applyFilters() {
    final filters = SearchFilters(
      category: _selectedCategory,
      certificationEligible: _certificationEligible,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      models: _selectedModels,
    );

    widget.onApplyFilters(filters);
    Navigator.of(context).pop();
  }
}

//
// class SearchFiltersWidget extends StatefulWidget {
//   final Function(SearchFilters) onApplyFilters;
//
//   const SearchFiltersWidget({
//     super.key,
//     required this.onApplyFilters,
//   });
//
//   @override
//   State<SearchFiltersWidget> createState() => _SearchFiltersWidgetState();
// }
//
// class _SearchFiltersWidgetState extends State<SearchFiltersWidget> {
//   String? _selectedCategory;
//   bool? _certificationEligible;
//   double? _minPrice;
//   double? _maxPrice;
//   String? _selectedModels;
//
//   final List<String> _categories = ['course', 'workshop'];
//   final List<String> _models = ['departments', 'course_types', 'courses'];
//   final List<String> _selectedModelsList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.7,
//         minChildSize: 0.5,
//         maxChildSize: 0.9,
//         expand: false,
//         builder: (context, scrollController) {
//           return SingleChildScrollView(
//             controller: scrollController,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Handle Bar
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Title
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Search Filters',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: _clearAllFilters,
//                       child: const Text('Clear All'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Category Filter
//                 _buildFilterSection(
//                   title: 'Category',
//                   child: Row(
//                     children: _categories.map((category) {
//                       return Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedCategory = _selectedCategory == category ? null : category;
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(right: 8),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             decoration: BoxDecoration(
//                               color: _selectedCategory == category
//                                   ? Colors.blue[100]
//                                   : Colors.grey[100],
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: _selectedCategory == category
//                                     ? Colors.blue
//                                     : Colors.transparent,
//                               ),
//                             ),
//                             child: Text(
//                               category.toUpperCase(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: _selectedCategory == category
//                                     ? Colors.blue[800]
//                                     : Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Certification Filter
//                 _buildFilterSection(
//                   title: 'Certification Eligible',
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: CheckboxListTile(
//                           title: const Text('Certification Available'),
//                           value: _certificationEligible ?? false,
//                           onChanged: (value) {
//                             setState(() {
//                               _certificationEligible = value == true ? true : null;
//                             });
//                           },
//                           contentPadding: EdgeInsets.zero,
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Price Range Filter
//                 _buildFilterSection(
//                   title: 'Price Range',
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 labelText: 'Min Price',
//                                 prefixText: '\$',
//                                 border: OutlineInputBorder(),
//                               ),
//                               onChanged: (value) {
//                                 _minPrice = double.tryParse(value);
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 labelText: 'Max Price',
//                                 prefixText: '\$',
//                                 border: OutlineInputBorder(),
//                               ),
//                               onChanged: (value) {
//                                 _maxPrice = double.tryParse(value);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Search Models Filter
//                 _buildFilterSection(
//                   title: 'Search In',
//                   child: Column(
//                     children: _models.map((model) {
//                       return CheckboxListTile(
//                         title: Text(_getModelDisplayName(model)),
//                         subtitle: Text(_getModelDescription(model)),
//                         value: _selectedModelsList.contains(model),
//                         onChanged: (value) {
//                           setState(() {
//                             if (value == true) {
//                               _selectedModelsList.add(model);
//                             } else {
//                               _selectedModelsList.remove(model);
//                             }
//                             _selectedModels = _selectedModelsList.join(', ');
//                           });
//                         },
//                         contentPadding: EdgeInsets.zero,
//                         controlAffinity: ListTileControlAffinity.leading,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // Apply Filters Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _applyFilters,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Apply Filters',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildFilterSection({
//     required String title,
//     required Widget child,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         child,
//       ],
//     );
//   }
//
//   String _getModelDisplayName(String model) {
//     switch (model) {
//       case 'departments':
//         return 'Departments';
//       case 'course_types':
//         return 'Course Types';
//       case 'courses':
//         return 'Courses';
//       default:
//         return model;
//     }
//   }
//
//   String _getModelDescription(String model) {
//     switch (model) {
//       case 'departments':
//         return 'Search in department names and descriptions';
//       case 'course_types':
//         return 'Search in course type categories';
//       case 'courses':
//         return 'Search in course titles and descriptions';
//       default:
//         return '';
//     }
//   }
//
//   void _clearAllFilters() {
//     setState(() {
//       _selectedCategory = null;
//       _certificationEligible = null;
//       _minPrice = null;
//       _maxPrice = null;
//       _selectedModels = null;
//       _selectedModelsList.clear();
//     });
//   }
//
//   void _applyFilters() {
//     final filters = SearchFilters(
//       category: _selectedCategory,
//       certificationEligible: _certificationEligible,
//       minPrice: _minPrice,
//       maxPrice: _maxPrice,
//       models: _selectedModels,
//     );
//
//     widget.onApplyFilters(filters);
//     Navigator.of(context).pop();
//   }
// }
