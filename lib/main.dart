import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fynt/features/settings/appearance/data/theme_service.dart';
import 'package:fynt/features/settings/appearance/logic/theme_controller.dart';
import 'package:fynt/features/authentication/logic/auth_controller.dart';
import 'package:fynt/features/onboarding/data/onboarding_repository.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/routing/app_router.dart';
import 'package:fynt/core/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fynt/features/settings/language/logic/language_controller.dart';
import 'package:fynt/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await Supabase.initialize(
    url: 'https://dzztxtttepayqevwdhvg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6enR4dHR0ZXBheXFldndkaHZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAwNDI0NDgsImV4cCI6MjA4NTYxODQ0OH0.qNUoVCxiiAkvnWzna-tUIQZGJPDfHRlldNqSTOv_2BQ',
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        ref.read(isRecoveringPasswordProvider.notifier).setRecovering(true);
        ref.read(routerProvider).go(AppRoutes.updatePassword.path);
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(languageControllerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      routerConfig: router,
      locale: currentLocale,
      theme: AppTheme.lightTheme(currentLocale.languageCode),
      darkTheme: AppTheme.darkTheme(currentLocale.languageCode),
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
