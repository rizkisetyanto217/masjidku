import 'package:go_router/go_router.dart';
import 'package:masjidku/routes/user_route.dart';
import 'package:masjidku/routes/dkm_route.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    dkmRoutes,
    userRoutes, // ShellRoute
    ...userExtraRoutes, // List<GoRoute>
  ],
);