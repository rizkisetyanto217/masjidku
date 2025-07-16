import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/dashboard/home/absence_study/details/study/details/faq/main/dkm_study_faq_screen.dart';
import 'package:masjidku/presentation/dashboard/home/main/dkm_main_screen.dart';
import 'pages_router.dart';

final ShellRoute dkmRoutes = ShellRoute(
  builder: (context, state, child) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(body: child), // Jangan pakai SafeArea global
    );
  },
  routes: [
    GoRoute(
      path: '/dkm',
      builder: (_, __) => const DkmMainScreen(),
      routes: _nestedDkmRoutes,
    ),
  ],
);

final List<GoRoute> _nestedDkmRoutes = [
  GoRoute(path: 'call-us', builder: (_, __) => const DkmCallUsScreen()),
  GoRoute(path: 'event', builder: (_, __) => const DkmEventScreen()),
  GoRoute(
    path: 'financial-report',
    builder: (_, __) => const DkmFinancialReportScreen(),
  ),
  GoRoute(
    path: 'information',
    builder: (_, __) => const DkmInformationScreen(),
    routes: [
      GoRoute(
        path: 'add-information',
        builder: (_, __) => const DkmAddInformationScreen(),
      ),
    ],
  ),
  GoRoute(
    path: 'notification',
    builder: (_, __) => const DkmNotificationScreen(),
    routes: [
      GoRoute(
        path: 'add-notification',
        builder: (_, __) => const DkmAddNotificationScreen(),
      ),
    ],
  ),
  GoRoute(
    path: 'post',
    builder: (_, __) => const DkmPostScreen(),
    routes: [
      GoRoute(path: 'create', builder: (_, __) => const DkmCreatePostScreen()),
    ],
  ),
  GoRoute(
    path: 'profil-admin',
    builder: (_, __) => const DkmProfilAdminScreen(),
  ),
  GoRoute(
    path: 'profil-masjid',
    builder: (_, __) => const DkmProfilMasjidScreen(),
    routes: [
      GoRoute(
        path: 'profil-dkm-pengajar',
        builder: (_, __) => const DkmProfilDkmPengajarScreen(),
      ),
      GoRoute(
        path: 'speech-dkm-pengajar',
        builder: (_, __) => const DkmSpeechDkmPengajarScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (_, __) => const DkmSpeechDkmPengajarDetailScreen(),
          ),
          GoRoute(
            path: 'add-speech',
            builder: (_, __) => const DkmAddSpeechDkmPengajarScreen(),
          ),
        ],
      ),
      GoRoute(
        path: 'profil-masjid-detail',
        builder: (_, __) => const DkmProfilMasjidDetailScreen(),
      ),
    ],
  ),
  GoRoute(path: 'stats', builder: (_, __) => const DkmStatsScreen()),
  GoRoute(
    path: 'study',
    builder: (_, __) => const DkmAbsenceStudyScreen(),
    routes: [
      GoRoute(path: 'add-study', builder: (_, __) => const DkmAddStudyScreen()),
      GoRoute(
        path: 'add-file-study',
        builder: (_, __) => const DkmAddFileStudyScreen(),
      ),
      GoRoute(
        path: 'add-study-confirm',
        builder: (_, __) => const DkmConfirmAddStudy(),
      ),
      GoRoute(path: 'thema', builder: (_, __) => const DkmThemaScreen()),
      GoRoute(
        path: 'study',
        builder: (_, __) => const DkmStudyScreen(),
        routes: [
          GoRoute(path: 'faq', builder: (_, __) => const DkmStudyFaqScreen()),
          GoRoute(
            path: 'information',
            builder: (_, __) => const DkmStudyInformationScreen(),
          ),
          GoRoute(
            path: 'transcription',
            builder: (_, __) => const DkmStudyTransciptionScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (_, __) => const DkmStudyEditTransciptionScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'summary',
            builder: (_, __) => const DkmStudySummaryScreen(),
          ),
          GoRoute(
            path: 'video',
            builder: (_, __) => const DkmStudyVideoScreen(),
          ),
          GoRoute(path: 'quiz', builder: (_, __) => const DkmStudyQuizScreen()),
          GoRoute(
            path: 'stats',
            builder: (_, __) => const DkmStudyStatsScreen(),
          ),
        ],
      ),
    ],
  ),
];
