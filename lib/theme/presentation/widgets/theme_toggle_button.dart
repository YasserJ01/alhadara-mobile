import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;

  const ThemeToggleButton({
    Key? key,
    this.iconColor,
    this.iconSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = false;

        if (state is ThemeLoaded) {
          isDarkMode = state.theme.isDarkMode;
        }

        return IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(isDarkMode),
              color: iconColor ?? Colors.white,
              size: iconSize,
            ),
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(const ToggleThemeMode());
          },
          tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        );
      },
    );
  }
}