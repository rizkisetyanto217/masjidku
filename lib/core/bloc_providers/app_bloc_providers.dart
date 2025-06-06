import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/home/donation/details/search_masjid/cubit/selected_masjid_cubit.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/quote/quotes_cubit.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';
import 'package:masjidku/presentation/all/home/home/search/cubit/masjid_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => SelectedMasjidCubit()),
        BlocProvider(create: (_) => QuotesCubit()..fetchQuotes()),
        BlocProvider(create: (_) => MasjidCubit()),
      ],
      child: child,
    );
  }
}
