import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(
        imageAsset,
        height: 250,
        errorBuilder: (_, __, ___) => const Icon(Icons.error),
      ),
      const SizedBox(height: 40),
      Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(214, 0, 27, 1.0),
        ),
        textAlign: TextAlign.center,
      ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(214, 0, 27, 1.0),
          ),
          textAlign: TextAlign.center,
        ),
        ],
      ),
    );
  }
}