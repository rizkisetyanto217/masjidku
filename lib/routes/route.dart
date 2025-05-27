import 'package:go_router/go_router.dart';
import 'main_scaffold.dart';
import 'pages_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const MasjidkuDashboard(),
          routes: [
            GoRoute(
              path: 'information',
              builder: (context, state) => const InformaationScreen(),
            ),
            GoRoute(
              path: 'collaboration',
              builder: (context, state) => const CollaborationHomeScreen(),
            ),
            GoRoute(
              path: 'explore',
              builder: (context, state) => const ExploreHomeScreen(),
            ),
            GoRoute(
              path: 'plan',
              builder: (context, state) => const PlanHomeScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/posting',
          builder: (context, state) => const PostinganScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (context, state) {
                final post = state.extra as Map<String, dynamic>;
                return DetailPostingScreen(post: post);
              },
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
            GoRoute(
              path: 'donation-history',
              builder: (context, state) => const DonationHistoryScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/my-activity',
          builder: (context, state) => const MyActivityScreen(),
          routes: [
            GoRoute(
              path: 'more',
              builder: (context, state) => const MoreScreen(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => const UserProfileScreen(),
                ),
                GoRoute(
                  path: 'faq',
                  builder: (context, state) => const FAQScreen(),
                ),
                GoRoute(
                  path: 'suggestion-feedback',
                  builder: (context, state) => const SuggestionFeedbackScreen(),
                ),
                GoRoute(
                  path: 'term',
                  builder: (context, state) => const TermScreen(),
                ),
                GoRoute(
                  path: 'theme',
                  builder: (context, state) => const ThemeScreen(),
                ),
                GoRoute(
                  path: 'appearance',
                  builder: (context, state) => const AppreanceScreen(),
                ),
                GoRoute(
                  path: 'certificate',
                  builder: (context, state) => const CertificateScreen(),
                ),
              ],
            ),
            GoRoute(
              path: 'lesson-history',
              builder: (context, state) => const LessonHistoryScreen(),
            ),
            GoRoute(
              path: 'stats',
              builder: (context, state) => const StatsScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/time-pray',
          builder: (context, state) => const TimePrayScreen(),
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
          routes: [
            GoRoute(
              path: 'full-profile',
              builder: (context, state) => const MasjidProfilScreen(),
            ),
            GoRoute(
              path: 'teacher',
              builder: (context, state) => const MasjidTeacherScreeen(),
            ),
            GoRoute(
              path: 'dkm',
              builder: (context, state) => const MasjidDKMScreen(),
            ),
            GoRoute(
              path: 'speech',
              builder: (context, state) => const SpeechScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'detail-posting',
          builder: (context, state) {
            final post = state.extra as Map<String, dynamic>;
            return MasjidsDetailPostingScreen(post: post);
          },
        ),
        GoRoute(
          path: 'information',
          builder: (context, state) => const InformationMasjidScreeen(),
        ),
        GoRoute(
          path: 'financial-report',
          builder: (context, state) => const FinancialReportMasjidScreen(),
        ),
        GoRoute(
          path: 'absence-study',
          builder: (context, state) => const AbsenceStudyMasjidScreen(),
        ),
        GoRoute(
          path: 'agenda',
          builder: (context, state) => const AgendaMasjidScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (context, state) {
                final data = state.extra as Map<String, String>;
                return DetailAgendaScreen(data: data);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'certificate',
          builder: (context, state) => const CertificateMasjidScreen(),
        ),
        GoRoute(
          path: 'donation',
          builder: (context, state) => const MasjidDonationScreen(),
        ),
      ],
    ),
  ],
);
