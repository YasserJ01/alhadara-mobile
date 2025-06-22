// lib/features/search/presentation/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SearchBarWidget extends StatefulWidget {
  final String? initialQuery;
  final Function(String) onSearchChanged;
  final VoidCallback onFilterTap;

  const SearchBarWidget({
    super.key,
    this.initialQuery,
    required this.onSearchChanged,
    required this.onFilterTap,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery ?? '');

    // Trigger initial search if there's an initial query
    if (widget.initialQuery?.isNotEmpty == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSearchChanged(widget.initialQuery!);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          // Back Button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: Colors.grey[600],
          ),

          // Search Input
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search courses, departments...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearchChanged,
            ),
          ),

          // Clear Button
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _controller.clear();
                widget.onSearchChanged('');
              },
              icon: const Icon(Icons.close),
              color: Colors.grey[600],
            ),

          // Filter Button
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: widget.onFilterTap,
              icon: const Icon(Icons.tune),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
