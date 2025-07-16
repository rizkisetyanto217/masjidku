import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/quiz/cubit/thema_study_quiz_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/quiz/cubit/thema_study_quiz_state.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/status_tag_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/study_card_component.dart';

import 'package:intl/intl.dart';

class ThemaStudyQuizScreen extends StatefulWidget {
  final String lectureId;

  const ThemaStudyQuizScreen({super.key, required this.lectureId});

  @override
  State<ThemaStudyQuizScreen> createState() => _ThemaStudyQuizScreenState();
}

class _ThemaStudyQuizScreenState extends State<ThemaStudyQuizScreen> {
  @override
  void initState() {
    super.initState();

    // ⛏️ Safe fetch once during init
    Future.microtask(() {
      context.read<LectureQuizCubit>().fetchLectureQuizzes(
        lectureId: widget.lectureId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soal Latihan disini"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<LectureQuizCubit, LectureQuizState>(
        builder: (context, state) {
          if (state is LectureQuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LectureQuizError) {
            return Center(child: Text(state.message));
          } else if (state is LectureQuizLoaded) {
            final quizList = state.quizzes;
            if (quizList.isEmpty) {
              return const Center(child: Text("Belum ada soal."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                final quiz = quizList[index];
                final dateFormatted = DateFormat(
                  "d MMMM y, HH:mm",
                  "id_ID",
                ).format(quiz.lectureSessionsQuizCreatedAt);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StudyCard(
                    title: quiz.lectureSessionsQuizTitle,
                    teacher:
                        quiz.lectureSessionsQuizDescription, // Bisa diganti jika ada field pengajar
                    date: dateFormatted,
                    tags: [
                      StatusTag(
                        "Materi & Soal : ${quiz.userLectureSessionsQuizGradeResult?.toStringAsFixed(1) ?? '-'}",
                        const Color(0xFF4CAF50),
                        Colors.white,
                      ),
                    ],
                    onTap: () {
                      context.push(
                        '/masjid/${quiz.masjidSlug}/absence-study/study/${quiz.lectureSessionsQuizLectureSessionId}/quiz',
                        extra: {
                          'quizId': quiz.lectureSessionsQuizId,
                          'quiz': quiz,
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
