import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/auth/login/login_screen.dart';
import 'package:masjidku/presentation/all/auth/register/register_screen.dart';
import 'package:masjidku/presentation/all/home/masjids/cubit/masjid_detail_cubit.dart';
import 'package:masjidku/presentation/all/home/masjids/details/donation/cubit/masjid_donation_cubit.dart';
import 'package:masjidku/presentation/all/home/masjids/details/information/cubit/notification_cubit.dart';
import 'package:masjidku/presentation/all/home/masjids/details/profile/main/cubit/masjid_profile_dkm_pengajar_cubit.dart';
import 'package:masjidku/presentation/all/home/masjids/details/profile/main/model/masjid_profile_model.dart';
import 'package:masjidku/presentation/all/home/masjids/model/masjid_detail_profile.dart';
import 'main_scaffold.dart';
import 'pages_router.dart';

final ShellRoute userRoutes = ShellRoute(
  builder: (context, state, child) => MainScaffold(child: child),
  routes: [
    GoRoute(
      path: '/',
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
  GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
  GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
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
    path: '/masjid/:slug',
    builder: (context, state) {
      final slug = state.pathParameters['slug']!;
      return BlocProvider(
        create: (_) => MasjidDetailCubit()..fetchMasjidDetail(slug),
        child: MasjidScreen(slug: slug),
      );
    },
    routes: [
      GoRoute(
        path: 'profile',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! MasjidDetailModel) {
            return const Scaffold(
              body: Center(child: Text("Data masjid tidak valid")),
            );
          }

          return BlocProvider(
            create: (_) => MasjidProfileTeacherCubit()..fetch(extra.masjidId),
            child: ProfilMasjidScreen(masjid: extra),
          );
        },
        routes: [
          GoRoute(
            path: 'full-profile',
            builder: (context, state) {
              final profile = state.extra as MasjidProfileModel;
              return MasjidProfilScreen(profile: profile);
            },
          ),
          GoRoute(
            path: 'teacher',
            builder: (context, state) {
              final masjid = state.extra as MasjidDetailModel;
              return BlocProvider(
                create:
                    (_) => MasjidProfileTeacherCubit()..fetch(masjid.masjidId),
                child: MasjidTeacherScreeen(slug: masjid.slug),
              );
            },
          ),
          GoRoute(
            path: 'dkm',
            builder: (context, state) {
              final masjid = state.extra as MasjidDetailModel;
              return BlocProvider(
                create:
                    (_) => MasjidProfileTeacherCubit()..fetch(masjid.masjidId),
                child: MasjidDKMScreen(slug: masjid.slug),
              );
            },
          ),

          GoRoute(
            path: 'speech',
            builder: (context, state) {
              final masjid = state.extra as MasjidDetailModel;
              return BlocProvider(
                create:
                    (_) => MasjidProfileTeacherCubit()..fetch(masjid.masjidId),
                child: SpeechScreen(slug: masjid.slug),
              );
            },
          ),
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
        builder: (context, state) {
          final extra = state.extra;
          if (extra == null || extra is! MasjidDetailModel) {
            return const Scaffold(
              body: Center(child: Text("Data masjid tidak ditemukan")),
            );
          }

          final masjid = extra;

          return BlocProvider(
            create:
                (_) => NotificationCubit()..fetchByMasjidId(masjid.masjidId),
            child: InformationMasjidScreeen(masjid: masjid),
          );
        },
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
          GoRoute(
            path: 'study',
            builder: (_, __) => const StudyScreen(),
            routes: [
              GoRoute(
                path: 'information',
                builder: (_, __) => const StudyInformationScreen(),
              ),
              GoRoute(
                path: 'quiz',
                builder: (_, __) => const StudyQuizScreen(),
              ),
              GoRoute(
                path: 'transcription',
                builder: (_, __) => const StudyTranscriptionScreen(),
              ),
              GoRoute(
                path: 'summary',
                builder: (_, __) => const StudySummaryScreen(),
              ),
              GoRoute(
                path: 'video',
                builder: (_, __) => const StudyVideoScreen(),
              ),
              GoRoute(path: 'faq', builder: (_, __) => const StudyFaqScreen()),
              GoRoute(
                path: 'question-user',
                builder: (_, __) => const StudyQuestionUserScreen(),
              ),
            ],
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
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! MasjidDetailModel) {
            return const Scaffold(
              body: Center(child: Text("Data masjid tidak valid")),
            );
          }

          return BlocProvider(
            create: (_) => MasjidDonationCubit()..setMasjid(extra),
            child: MasjidDonationScreen(masjid: extra),
          );
        },
      ),
    ],
  ),
];
