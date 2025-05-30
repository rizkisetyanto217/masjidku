// user_routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main_scaffold.dart';
import 'pages_router.dart';

final ShellRoute userRoutes = ShellRoute(
  builder: (context, state, child) => MainScaffold(child: child),
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const MasjidkuMain(),
      routes: [
        GoRoute(
          path: 'information',
          builder: (_, __) => const InformaationScreen(),
        ),

        GoRoute(path: 'plan', builder: (_, __) => const PlanHomeScreen()),
      ],
    ),

    GoRoute(
      path: '/posting',
      builder: (_, __) => const PostinganScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) {
            final post = state.extra;
            if (post is! Map<String, dynamic>) {
              return const Scaffold(
                body: Center(child: Text('Invalid post data')),
              );
            }
            return DetailPostingScreen(post: post);
          },
        ),
      ],
    ),

    GoRoute(
      path: '/donation',
      builder: (_, __) => const DonationScreen(),
    ),

    GoRoute(path: '/my-activity', builder: (_, __) => const MyActivityScreen()),

    GoRoute(path: '/time-pray', builder: (_, __) => const TimePrayScreen()),
  ],
);

final List<GoRoute> userExtraRoutes = [
  GoRoute(
    path: '/home/collaboration',
    builder: (_, __) => const CollaborationHomeScreen(),
  ),
  GoRoute(path: '/home/explore', builder: (_, __) => const ExploreHomeScreen()),
  GoRoute(
    path: '/donation/donation-confirmation',
    builder: (_, __) => const DetailDonationConfirm(),
  ),
  GoRoute(
    path: '/donation/donation-history',
    builder: (_, __) => const DonationHistoryScreen(),
  ),
  GoRoute(
    path: '/my-activity/more',
    builder: (_, __) => const MoreScreen(),
    routes: [
      GoRoute(path: 'profile', builder: (_, __) => const UserProfileScreen()),
      GoRoute(path: 'faq', builder: (_, __) => const FAQScreen()),
      GoRoute(
        path: 'suggestion-feedback',
        builder: (_, __) => const SuggestionFeedbackScreen(),
      ),
      GoRoute(path: 'term', builder: (_, __) => const TermScreen()),
      GoRoute(path: 'theme', builder: (_, __) => const ThemeScreen()),
      GoRoute(path: 'appearance', builder: (_, __) => const AppreanceScreen()),
      GoRoute(
        path: 'certificate',
        builder: (_, __) => const CertificateScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/my-activity/lesson-history',
    builder: (_, __) => const LessonHistoryScreen(),
  ),
  GoRoute(path: '/my-activity/stats', builder: (_, __) => const StatsScreen()),
  GoRoute(path: '/search', builder: (_, __) => const SearchMasjidScreen()),
];
