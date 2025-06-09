// Refactored StudyQuizScreen with per-question answer tracking
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class StudyQuestion {
  final String question;
  final List<String> options;
  final String correct;

  StudyQuestion({
    required this.question,
    required this.options,
    required this.correct,
  });
}

class StudyQuizState {
  final List<StudyQuestion> questions;
  final int currentIndex;
  final List<int> correctIndexes;
  final int progress;
  final String? selectedAnswer;
  final bool isSubmitted;
  final Map<int, bool> answeredResults;

  StudyQuizState({
    required this.questions,
    required this.currentIndex,
    required this.correctIndexes,
    required this.progress,
    this.selectedAnswer,
    this.isSubmitted = false,
    required this.answeredResults,
  });

  StudyQuizState copyWith({
    int? currentIndex,
    List<int>? correctIndexes,
    int? progress,
    String? selectedAnswer,
    bool? isSubmitted,
    Map<int, bool>? answeredResults,
  }) {
    return StudyQuizState(
      questions: questions,
      currentIndex: currentIndex ?? this.currentIndex,
      correctIndexes: correctIndexes ?? this.correctIndexes,
      progress: progress ?? this.progress,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      answeredResults: answeredResults ?? this.answeredResults,
    );
  }
}

class StudyQuizCubit extends Cubit<StudyQuizState> {
  StudyQuizCubit()
    : super(
        StudyQuizState(
          questions: [
            StudyQuestion(
              question: "Apa rukun iman ketiga ...",
              options: [
                "Iman kepada Allah ta’ala",
                "Iman kepada malaikat",
                "Iman kepada kitab-kitab",
                "Iman kepada rasul",
              ],
              correct: "Iman kepada kitab-kitab",
            ),
            StudyQuestion(
              question: "Apa rukun islam pertama ...",
              options: ["Zakat", "Shalat", "Syahadat", "Haji"],
              correct: "Syahadat",
            ),
          ],
          currentIndex: 0,
          correctIndexes: [],
          progress: 0,
          answeredResults: {},
        ),
      );

  void selectAnswer(String answer) {
    emit(state.copyWith(selectedAnswer: answer, isSubmitted: false));
  }

  void submitAnswer(BuildContext context) {
    final current = state.questions[state.currentIndex];
    final isCorrect = state.selectedAnswer == current.correct;
    final alreadyCorrect = state.correctIndexes.contains(state.currentIndex);

    final updatedCorrect = List<int>.from(state.correctIndexes);
    if (isCorrect && !alreadyCorrect) {
      updatedCorrect.add(state.currentIndex);
    }

    final updatedResults = Map<int, bool>.from(state.answeredResults);
    updatedResults[state.currentIndex] = isCorrect;

    emit(
      state.copyWith(
        correctIndexes: updatedCorrect,
        progress: updatedCorrect.length,
        isSubmitted: true,
        answeredResults: updatedResults,
      ),
    );

    if (updatedCorrect.length == state.questions.length) {
      Future.delayed(const Duration(milliseconds: 800), () {
        context.go('/masjid/absence-study/study/quiz/result');
      });
    }
  }

  void nextQuestion() {
    final total = state.questions.length;
    int nextIndex = state.currentIndex;

    for (int i = 0; i < total; i++) {
      final next = (state.currentIndex + i + 1) % total;
      if (!state.correctIndexes.contains(next)) {
        nextIndex = next;
        break;
      }
    }

    emit(
      state.copyWith(
        currentIndex: nextIndex,
        selectedAnswer: null,
        isSubmitted: false,
      ),
    );
  }
}

class StudyQuizScreen extends StatelessWidget {
  const StudyQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudyQuizCubit(),
      child: const _StudyQuizView(),
    );
  }
}

class _StudyQuizView extends StatelessWidget {
  const _StudyQuizView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BlocBuilder<StudyQuizCubit, StudyQuizState>(
                    builder: (context, state) {
                      final value =
                          state.questions.isEmpty
                              ? 0
                              : state.progress / state.questions.length;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: value.toDouble(),

                          minHeight: 6,
                          color: const Color(0xFFFFA500), // warna oranye
                          backgroundColor: Colors.grey.shade300,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {}, // bisa dikasih menu nanti
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<StudyQuizCubit, StudyQuizState>(
        builder: (context, state) {
          final cubit = context.read<StudyQuizCubit>();

          if (state.correctIndexes.length == state.questions.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final question = state.questions[state.currentIndex];
          final isCorrect = state.answeredResults[state.currentIndex] ?? false;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionTextWidget(text: question.question),
              ...question.options.map(
                (opt) => _buildAnswerOption(
                  option: opt,
                  selectedAnswer: state.selectedAnswer,
                  correctAnswer: question.correct,
                  isSubmitted: state.isSubmitted,
                  onTap: () => cubit.selectAnswer(opt),
                ),
              ),
              const Spacer(),
              state.isSubmitted
                  ? _buildFeedbackBox(
                    isCorrect: isCorrect,
                    onNext: () => cubit.nextQuestion(),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: MainButton(
                      label: "Submit",
                      onPressed:
                          state.selectedAnswer != null
                              ? () => cubit.submitAnswer(context)
                              : null,
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnswerOption({
    required String option,
    required String? selectedAnswer,
    required String correctAnswer,
    required bool isSubmitted,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedAnswer == option;
    final isCorrect = option == correctAnswer;
    final isWrongSelected = isSubmitted && isSelected && !isCorrect;
    final isCorrectSelected = isSubmitted && isSelected && isCorrect;

    Color? color;
    if (isSubmitted) {
      if (isCorrectSelected) {
        color = Colors.green.shade100;
      } else if (isWrongSelected) {
        color = Colors.red.shade100;
      } else {
        color = Colors.grey.shade200;
      }
    } else if (isSelected) {
      color = Colors.blue.shade100;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: isSubmitted ? null : onTap,
        child: Text(option),
      ),
    );
  }

  Widget _buildFeedbackBox({
    required bool isCorrect,
    required VoidCallback onNext,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFDFF6DD) : const Color(0xFFFDEDED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? "Benar" : "Salah",
                style: TextStyle(
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.menu_book, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          MainButton(
            label: "Soal Berikutnya",
            backgroundColor:
                isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFB71C1C),
            foregroundColor: Colors.white,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudyQuizCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LinearProgressIndicator(
        value: state.progress / state.questions.length,
        minHeight: 6,
        color: Colors.orange,
        backgroundColor: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class QuestionTextWidget extends StatelessWidget {
  final String text;

  const QuestionTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
