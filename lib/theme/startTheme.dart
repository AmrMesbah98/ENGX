import 'package:flutter/material.dart';
import 'package:lets_theme/lets_theme.dart';

class RunTheme extends StatefulWidget {
  const RunTheme({super.key});



  @override
  State<RunTheme> createState() => _RunThemeState();
}

class _RunThemeState extends State<RunTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            children: [

              const SizedBox(height: 40),
              Text(
                'Current Theme Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                LetsTheme.of(context).mode.name.toUpperCase(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              const LetsThemeToggle(
                selectionMode: LetsThemeToggleSelectionMode.infinite,
                labels: [
                  'Day Mode',
                  'Night Mode',
                  'Auto Mode',
                ],
              ),
              const SizedBox(height: 24),
              const LetsThemeToggle.card(),
              const SizedBox(height: 24),
              const LetsThemeToggle.compact(),
              const SizedBox(height: 24),
              const LetsThemeToggle.label(),
              const SizedBox(height: 24),
              const LetsThemeToggle.icon(),
            ],
          ),
        ),
      ),
    );
  }
}