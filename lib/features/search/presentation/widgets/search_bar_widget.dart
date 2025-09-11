// lib/features/search/presentation/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';


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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = Colors.grey[100]!;
        Color borderColor = Colors.grey[300]!;
        Color iconColor = Colors.grey[600]!;
        Color textColor = Colors.black;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getCardColor(themeState.theme);
          borderColor = AppThemeHelper.getSecondaryTextColor(themeState.theme).withOpacity(0.3);
          iconColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
        }

        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              // Back Button
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, color: iconColor),
              ),

              // Search Input
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: _onSearchChanged,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Search courses, departments...',
                    hintStyle: TextStyle(color: iconColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                  icon: Icon(Icons.close, color: iconColor),
                ),

              // Filter Button
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: widget.onFilterTap,
                  icon: Icon(Icons.tune, color: iconColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
