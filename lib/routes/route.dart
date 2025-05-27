import 'package:go_router/go_router.dart';
import 'pages_router.dart'; // Pastikan path sesuai

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MasjidkuDashboard(),
      routes: [
        GoRoute(
          path: 'informasi',
          builder: (context, state) => const InformasiScreeen(),
        ),
      ],
    ),
    GoRoute(
      path: '/donasi',
      builder: (context, state) => const DonationScreen(),
      routes: [
        GoRoute(
          path: 'donation-confirmation',
          builder: (context, state) => const DetailDonationConfirm(),
        ),
      ],
    ),
    GoRoute(
      path: '/posting',
      builder: (context, state) => const PostinganScreen(),
    ),
    GoRoute(
      path: '/time-pray',
      builder: (context, state) => const TimePrayScreen(),
    ),
    GoRoute(
      path: '/my-activity',
      builder: (context, state) => const MyActivityScreen(),
      routes: [
        GoRoute(
          path: 'more', // TANPA /
          builder: (context, state) => const MoreScreen(),
          routes: [
            GoRoute(
              path: 'profile', // <-- child dari /my-activity/more
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              path: 'faq', // <-- child dari /my-activity/more
              builder: (context, state) => const FAQScreen(),
            ),
            GoRoute(
              path: 'suggestion-feedback', // <-- child dari /my-activity/more
              builder: (context, state) => const SuggestionFeedbackScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchMasjidScreen(),
    ),
    GoRoute(
      path: '/masjid',
      builder: (context, state) => const MasjidScreen(),
      routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfilMasjidPage(),
        ),
      ],
    ),
    // GoRoute(
    //   path: '/profil',
    //   builder: (context, state) => const ProfileScreen(),
    // ),
  ],
);
