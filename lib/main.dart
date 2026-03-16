import 'package:fintrack/features/appearance/data/theme_service.dart';
import 'package:fintrack/features/appearance/logic/theme_controller.dart';
import 'package:fintrack/features/onboarding/data/onboarding_repository.dart';
import 'package:fintrack/routing/app_router.dart';
import 'package:fintrack/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dzztxtttepayqevwdhvg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6enR4dHR0ZXBheXFldndkaHZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAwNDI0NDgsImV4cCI6MjA4NTYxODQ0OH0.qNUoVCxiiAkvnWzna-tUIQZGJPDfHRlldNqSTOv_2BQ',
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        onboardingRepositoryProvider.overrideWithValue(
          OnboardingRepository(sharedPreferences),
        ),
        themeServiceProvider.overrideWithValue(
          ThemeRepository(sharedPreferences),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
        ref.read(isRecoveringPasswordProvider.notifier).setRecovering(true);
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: ClipRect(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
