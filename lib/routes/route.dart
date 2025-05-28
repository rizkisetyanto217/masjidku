import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main_scaffold.dart';
import 'pages_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Root shell (dengan bottom navigation wrapper)
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        // Home group
        GoRoute(
          path: '/home',
          builder: (context, state) => const MasjidkuDashboard(),
          routes: [
            GoRoute(
              path: 'information',
              builder: (_, __) => const InformaationScreen(),
            ),
            GoRoute(
              path: 'collaboration',
              builder: (_, __) => const CollaborationHomeScreen(),
            ),
            GoRoute(
              path: 'explore',
              builder: (_, __) => const ExploreHomeScreen(),
            ),
            GoRoute(path: 'plan', builder: (_, __) => const PlanHomeScreen()),
          ],
        ),

        // Postingan
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

        // Donasi
        GoRoute(
          path: '/donasi',
          builder: (_, __) => const DonationScreen(),
          routes: [
            GoRoute(
              path: 'donation-confirmation',
              builder: (_, __) => const DetailDonationConfirm(),
            ),
            GoRoute(
              path: 'donation-history',
              builder: (_, __) => const DonationHistoryScreen(),
            ),
          ],
        ),

        // Aktivitas pengguna
        GoRoute(
          path: '/my-activity',
          builder: (_, __) => const MyActivityScreen(),
          routes: [
            GoRoute(
              path: 'more',
              builder: (_, __) => const MoreScreen(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (_, __) => const UserProfileScreen(),
                ),
                GoRoute(path: 'faq', builder: (_, __) => const FAQScreen()),
                GoRoute(
                  path: 'suggestion-feedback',
                  builder: (_, __) => const SuggestionFeedbackScreen(),
                ),
                GoRoute(path: 'term', builder: (_, __) => const TermScreen()),
                GoRoute(path: 'theme', builder: (_, __) => const ThemeScreen()),
                GoRoute(
                  path: 'appearance',
                  builder: (_, __) => const AppreanceScreen(),
                ),
                GoRoute(
                  path: 'certificate',
                  builder: (_, __) => const CertificateScreen(),
                ),
              ],
            ),
            GoRoute(
              path: 'lesson-history',
              builder: (_, __) => const LessonHistoryScreen(),
            ),
            GoRoute(path: 'stats', builder: (_, __) => const StatsScreen()),
          ],
        ),

        // Waktu sholat
        GoRoute(path: '/time-pray', builder: (_, __) => const TimePrayScreen()),
      ],
    ),

    // Search
    GoRoute(path: '/search', builder: (_, __) => const SearchMasjidScreen()),

    // Masjid
    GoRoute(
      path: '/masjid',
      builder: (_, __) => const MasjidScreen(),
      routes: [
        GoRoute(
          path: 'profile',
          builder: (_, __) => const ProfilMasjidPage(),
          routes: [
            GoRoute(
              path: 'full-profile',
              builder: (_, __) => const MasjidProfilScreen(),
            ),
            GoRoute(
              path: 'teacher',
              builder: (_, __) => const MasjidTeacherScreeen(),
            ),
            GoRoute(path: 'dkm', builder: (_, __) => const MasjidDKMScreen()),
            GoRoute(path: 'speech', builder: (_, __) => const SpeechScreen()),
          ],
        ),
        GoRoute(
          path: 'detail-posting',
          builder: (context, state) {
            final post = state.extra;
            if (post is! Map<String, dynamic>) {
              return const Scaffold(
                body: Center(child: Text('Invalid post data')),
              );
            }
            return MasjidsDetailPostingScreen(post: post);
          },
        ),
        GoRoute(
          path: 'information',
          builder: (_, __) => const InformationMasjidScreeen(),
        ),
        GoRoute(
          path: 'financial-report',
          builder: (_, __) => const FinancialReportMasjidScreen(),
        ),
        GoRoute(
          path: 'absence-study',
          builder: (_, __) => const AbsenceStudyMasjidScreen(),
          routes: [
            GoRoute(
              path: 'thema-study',
              builder: (_, __) => const ThemaStudyScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'agenda',
          builder: (_, __) => const AgendaMasjidScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (context, state) {
                final data = state.extra;
                if (data is! Map<String, String>) {
                  return const Scaffold(
                    body: Center(child: Text('Invalid agenda data')),
                  );
                }
                return DetailAgendaScreen(data: data);
              },
            ),
          ],
        ),
        GoRoute(path: 'event', builder: (_, _) => const MasjidEventScreen()),
        GoRoute(
          path: 'certificate',
          builder: (_, __) => const CertificateMasjidScreen(),
        ),
        GoRoute(
          path: 'donation',
          builder: (_, __) => const MasjidDonationScreen(),
        ),
      ],
    ),
  ],
);
