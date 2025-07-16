// import 'package:bloc/bloc.dart';

// class QuizQuestion {
//   final String question;
//   final List<String> options;
//   final String correctAnswer;

//   QuizQuestion({
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//   });
// }

// class StudyQuizState {
//   final int currentIndex;
//   final List<int> correctIndexes;
//   final List<int> wrongIndexes;
//   final List<QuizQuestion> questions;

//   StudyQuizState({
//     required this.currentIndex,
//     required this.correctIndexes,
//     required this.wrongIndexes,
//     required this.questions,
//   });

//   int get progress => correctIndexes.length;

//   StudyQuizState copyWith({
//     int? currentIndex,
//     List<int>? correctIndexes,
//     List<int>? wrongIndexes,
//   }) {
//     return StudyQuizState(
//       currentIndex: currentIndex ?? this.currentIndex,
//       correctIndexes: correctIndexes ?? this.correctIndexes,
//       wrongIndexes: wrongIndexes ?? this.wrongIndexes,
//       questions: questions,
//     );
//   }
// }

// class StudyQuizCubit extends Cubit<StudyQuizState> {
//   StudyQuizCubit()
//     : super(
//         StudyQuizState(
//           currentIndex: 0,
//           correctIndexes: [],
//           wrongIndexes: [],
//           questions: [
//             QuizQuestion(
//               question: "Apa rukun iman ketiga?",
//               options: [
//                 "Iman kepada Allah ta’ala",
//                 "Iman kepada malaikat",
//                 "Iman kepada kitab-kitab",
//                 "Iman kepada rasul",
//               ],
//               correctAnswer: "Iman kepada kitab-kitab",
//             ),
//             QuizQuestion(
//               question: "Siapa rasul terakhir?",
//               options: ["Musa", "Isa", "Muhammad", "Ibrahim"],
//               correctAnswer: "Muhammad",
//             ),
//           ],
//         ),
//       );

//   void answer(String selected) {
//     final q = state.questions[state.currentIndex];
//     final isCorrect = selected == q.correctAnswer;

//     if (isCorrect) {
//       emit(
//         state.copyWith(
//           correctIndexes: [...state.correctIndexes, state.currentIndex],
//           currentIndex: _nextIndex(),
//         ),
//       );
//     } else {
//       emit(
//         state.copyWith(
//           wrongIndexes: [...state.wrongIndexes, state.currentIndex],
//           currentIndex: _nextIndex(),
//         ),
//       );
//     }
//   }

//   int _nextIndex() {
//     final total = state.questions.length;

//     // Selesai jika semua soal sudah benar
//     if (state.correctIndexes.length == total) return total;

//     // Cek soal berikutnya
//     int i = state.currentIndex + 1;
//     if (i >= total) i = 0;

//     // Ulangi soal salah yang belum dijawab benar
//     while (state.correctIndexes.contains(i)) {
//       i++;
//       if (i >= total) i = 0;
//     }

//     return i;
//   }
// }
