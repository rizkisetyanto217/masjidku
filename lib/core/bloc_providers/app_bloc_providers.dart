import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'package:masjidku/presentation/all/auth/login/service/auth_service.dart';
import 'package:masjidku/presentation/all/donation/details/search_masjid/cubit/selected_masjid_cubit.dart';
import 'package:masjidku/presentation/all/home/main/cubit/quote/quotes_cubit.dart';
import 'package:masjidku/presentation/all/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';
import 'package:masjidku/presentation/all/home/search/cubit/masjid_cubit.dart';
import 'package:masjidku/presentation/all/masjids/donation/cubit/masjid_donation_cubit.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_event_sessions_cubit.dart';
import 'package:masjidku/presentation/all/masjids/information/cubit/notification_cubit.dart';
import 'package:masjidku/presentation/all/masjids/profile/main/cubit/masjid_profile_dkm_pengajar_cubit.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_cubit.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_google_cubit.dart';
import 'package:masjidku/presentation/all/my_activity/main/cubit/user_profile_section_cubit.dart';

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
        BlocProvider(create: (_) => NotificationCubit()),
        BlocProvider(create: (_) => MasjidProfileTeacherCubit()),
        BlocProvider(create: (_) => MasjidDonationCubit()),
        BlocProvider(create: (_) => LoginCubit(authService: AuthService())),
        BlocProvider(
          create: (_) => LoginGoogleCubit(authService: AuthService()),
        ),
        BlocProvider(create: (_) => AuthCubit()..checkLoginStatus()),
        BlocProvider<EventSessionsCubit>(
          create: (context) => EventSessionsCubit(),
        ),
        BlocProvider(create: (_) => UserProfileCubit()),
      ],
      child: child,
    );
  }
}
