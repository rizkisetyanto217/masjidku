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
    GoRoute(path: '/donation', builder: (_, __) => const DonationScreen()),
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
    path: '/donation/search-masjid-donation',
    builder: (_, __) => const DonationSearchMasjidScreen(),
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
    builder: (_, __) => const MyActivityLessonHistoryScreen(),
  ),
  GoRoute(
    path: '/my-activity/lesson-income',
    builder: (_, __) => const MyActivityLessonIncomeScreen(),
  ),
  GoRoute(path: '/my-activity/stats', builder: (_, __) => const StatsScreen()),
  GoRoute(path: '/search', builder: (_, __) => const SearchMasjidScreen()),
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
        builder: (_, __) => const MasjidFinancialReportScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return MasjidFinancialReportDetailScreen(data: data);
            },
          ),
        ],
      ),
      GoRoute(
        path: 'absence-study',
        builder: (_, __) => const AbsenceStudyMasjidScreen(),
        routes: [
          GoRoute(
            path: 'thema-study',
            builder: (_, __) => const ThemaStudyScreen(),
            routes: [
              GoRoute(path: 'quiz', builder: (_, __) => const QuizScreen()),
              GoRoute(
                path: 'faq',
                builder: (_, __) => const DetailThemaStudyFaqScreen(),
              ),
              GoRoute(
                path: 'information',
                builder: (_, __) => const DetailThemaStudyInformationScreen(),
              ),
              GoRoute(
                path: 'transcription',
                builder: (_, __) => const DetailThemaStudyTranscriptionScreen(),
              ),
              GoRoute(
                path: 'stats',
                builder: (_, __) => const DetailThemaStudyStatsUserScreen(),
              ),
              GoRoute(
                path: 'note',
                builder: (_, __) => const DetailThemaStudyNoteUserScreen(),
              ),
              GoRoute(
                path: 'suggestion',
                builder:
                    (_, __) => const DetailThemaStudySuggestionUserScreen(),
              ),
              GoRoute(
                path: 'summary',
                builder: (_, __) => const DetailThemaStudySummaryScreen(),
              ),
              GoRoute(
                path: 'video',
                builder: (_, __) => const ThemaVideoScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: 'study',
        builder: (_, __) => const StudyScreen(),
        routes: [
          GoRoute(
            path: 'information',
            builder: (_, __) => const StudyInformationScreen(),
          ),
          GoRoute(path: 'quiz', builder: (_, __) => const StudyQuizScreen()),
          GoRoute(
            path: 'transcription',
            builder: (_, __) => const StudyTranscriptionScreen(),
          ),
          GoRoute(
            path: 'summary',
            builder: (_, __) => const StudySummaryScreen(),
          ),
          GoRoute(path: 'video', builder: (_, __) => const StudyVideoScreen()),
          GoRoute(path: 'faq', builder: (_, __) => const StudyFaqScreen()),
          GoRoute(
            path: 'question-user',
            builder: (_, __) => const StudyQuestionUserScreen(),
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
];
