import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/auth/login/login_screen.dart';
import 'package:masjidku/presentation/all/auth/register/register_screen.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/document/pdf_viewer_screen.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/document/thema_doc_screen.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/quiz/cubit/thema_study_quiz_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/summary/summary_view_screen.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/transciption/transcription_view_screen.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/video/cubit/video_cubit.dart';
import 'package:masjidku/presentation/all/masjids/event/detail/masjid_event_sessions_detail.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_sessions_model.dart';
import 'package:masjidku/presentation/all/masjids/main/cubit/masjid_detail_cubit.dart';
import 'package:masjidku/presentation/all/masjids/donation/cubit/masjid_donation_cubit.dart';
import 'package:masjidku/presentation/all/masjids/information/cubit/notification_cubit.dart';
import 'package:masjidku/presentation/all/masjids/profile/main/cubit/masjid_profile_dkm_pengajar_cubit.dart';
import 'package:masjidku/presentation/all/masjids/profile/main/model/masjid_profile_model.dart';
import 'package:masjidku/presentation/all/masjids/main/model/masjid_detail_profile.dart';
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
  GoRoute(
    path: '/pdf-viewer',
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      return PdfViewerScreen(title: extra['title'], url: extra['url']);
    },
  ),
  GoRoute(
    path: '/material-transcript-view',
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;

      final title = extra?['title'] ?? 'Transkrip Materi';
      final content = extra?['content'] ?? '';

      return TranscriptViewScreen(title: title, content: content);
    },
  ),
  GoRoute(
    path: '/material-summary-view',
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;

      final title = extra?['title'] ?? 'Ringkasan Materi';
      final content = extra?['content'] ?? '';

      return SummaryViewScreen(title: title, content: content);
    },
  ),

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
        builder: (_, __) => const MasjidAbsenceStudyScreen(),
        routes: [
          GoRoute(
            path: 'thema-study',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return ThemaStudyScreen(
                data: extra['data'],
                masjidSlug: extra['masjidSlug'],
              );
            },
            routes: [
              GoRoute(
                path: 'quiz',
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;

                  final lectureId = extra?['lectureId'] as String?;
                  final lecture = extra?['lecture'];
                  final masjidId =
                      (lecture is MasjidLectureModel) ? lecture.masjidId : null;

                  if (lectureId != null && masjidId != null) {
                    return BlocProvider(
                      create: (_) => LectureQuizCubit(),
                      child: ThemaStudyQuizScreen(lectureId: lectureId),
                    );
                  }

                  return const Scaffold(
                    body: Center(
                      child: Text('Parameter tidak lengkap untuk halaman kuis'),
                    ),
                  );
                },
              ),

              GoRoute(
                path: 'faq',
                builder: (_, __) => const DetailThemaStudyFaqScreen(),
              ),
              GoRoute(
                path: 'information',
                builder:
                    (context, state) =>
                        const DetailThemaStudyInformationScreen(),
              ),
              GoRoute(
                path: 'transcription/:lectureId',
                builder: (context, state) {
                  final lectureId = state.pathParameters['lectureId']!;
                  return BlocProvider(
                    create: (_) => LectureSessionMaterialAssetCubit(),
                    child: ThemeStudyTranscriptionScreen(lectureId: lectureId),
                  );
                },
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
                path: 'document/:lectureId',
                builder: (context, state) {
                  final lectureId = state.pathParameters['lectureId']!;
                  return BlocProvider(
                    create: (_) => LectureSessionMaterialAssetCubit(),
                    child: DocsThemaScreen(lectureId: lectureId),
                  );
                },
              ),
              GoRoute(
                path: 'summary/:lectureId',
                builder: (context, state) {
                  final lectureId = state.pathParameters['lectureId']!;
                  return BlocProvider(
                    create: (_) => LectureSessionMaterialAssetCubit(),
                    child: ThemeStudySummaryScreen(lectureId: lectureId),
                  );
                },
              ),

              GoRoute(
                path: 'video/:lectureId',
                builder: (context, state) {
                  final lectureId = state.pathParameters['lectureId']!;
                  return BlocProvider(
                    create: (_) => VideoCubit(),
                    child: ThemaVideoScreen(lectureId: lectureId),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'study/:lectureSessionId',
            builder: (context, state) {
              final lectureSessionId =
                  state.pathParameters['lectureSessionId']!;
              final masjidSlug =
                  state.extra is Map<String, dynamic>
                      ? (state.extra as Map<String, dynamic>)['masjidSlug'] ??
                          'unknown'
                      : 'unknown';

              return MasjidStudyScreen(
                lectureSessionId: lectureSessionId,
                masjidSlug: masjidSlug,
                extra: state.extra,
              );
            },
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
        builder: (_, __) => const AgendaKajianMasjidScreen(),
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
      GoRoute(
        path: 'event',
        builder: (context, state) {
          final slug = state.pathParameters['slug']!;

          // ❗ Gunakan try-cast
          final masjidId = state.extra;
          if (masjidId is! String) {
            return const Scaffold(
              body: Center(child: Text('Masjid ID tidak valid')),
            );
          }

          return MasjidEventScreen(slug: slug, masjidId: masjidId);
        },
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              final session = state.extra;
              if (session is! MasjidEventSessionsModel) {
                return const Scaffold(
                  body: Center(child: Text('Sesi acara tidak valid')),
                );
              }

              return MasjidEventSessionDetailScreen(session: session);
            },
          ),
        ],
      ),

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
