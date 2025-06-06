import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/bloc_providers/app_bloc_providers.dart';
import 'package:masjidku/core/themes/app_theme.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';

import 'package:masjidku/routes/app_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Paksa status bar transparan + ikon putih
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // biar ikut warna header
      statusBarIconBrightness: Brightness.light, // ikon putih
    ),
  );

  runApp(const MasjidkuApp());
}

class MasjidkuApp extends StatelessWidget {
  const MasjidkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBlocProviders(child: _AppWithTheme());
  }
}

class _AppWithTheme extends StatelessWidget {
  // ignore: unused_element_parameter
  const _AppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Masjidku',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            quill.FlutterQuillLocalizations.delegate, // ⬅️ ini penting
          ],
          supportedLocales: const [
            Locale('en'), // Tambahkan locale lain jika perlu
          ],
          builder: (context, child) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
