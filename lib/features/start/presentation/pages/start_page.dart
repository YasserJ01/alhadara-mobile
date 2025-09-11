import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../localization/presentation/widgets/language_switcher.dart';
import '../../../../theme/presentation/widgets/theme_toggle_button.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../notifications/presentation/bloc/notification_state.dart';
import '../widgets/start_logo.dart';
import '../widgets/start_buttons.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
        elevation: 0,
        actions: [
          const ThemeToggleButton(
            iconColor: Colors.white,
            iconSize: 24.0,
          ),
          const SizedBox(width: 8),

          // Language Switcher
          const LanguageSwitcher(),
          const SizedBox(width: 8),

          // Notifications
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              int unreadCount = 0;
              if (state is NotificationLoaded) {
                unreadCount = state.unreadCount;
              }

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const StartLogo(), // Company logo
            // Welcome section with localized text
            Column(
              children: [
                Text(
                  l10n.welcome,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.welcomeSubtitle,
                  style: const TextStyle(
                    fontSize: 15.2,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const StartButtons(), // Sign in + Guest buttons
          ],
        ),
      ),
    );
  }
}
