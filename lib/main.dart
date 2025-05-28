import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/themes/app_theme.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/routes/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MasjidkuApp());
}

class MasjidkuApp extends StatelessWidget {
  const MasjidkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: const _AppWithTheme(),
    );
  }
}

class _AppWithTheme extends StatelessWidget {
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
          builder: (context, child) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: child, // 👈 ini wajib agar UI tetap muncul
              ),
            );
          },
        );
      },
    );
  }
}
