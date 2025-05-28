import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/themes/app_theme.dart';
import 'package:masjidku/routes/route.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Tambahan penting
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
      ],
      child: const MyAppWrapper(),
    );
  }
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

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
        );
      },
    );
  }
}
