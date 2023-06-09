import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../domain/entities/quiz/quiz.dart';
import '../../viewmodel/module.dart';
import '../gif_widget.dart';
import '../quiz_tile.dart';

class LearnedQuizzesList extends ConsumerWidget {
  const LearnedQuizzesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String noQuizTitle = 'No Quizzes Learned';
    final quizzesListState = ref.watch(quizListState);
    List<Quiz> quizzesList = quizzesListState.quizList
        .where((quiz) => quiz.isLearned)
        .toList();

    return quizzesList.isEmpty
        ? const NoDataNotify(
            gifPath: AssetPaths.iKnowAnswerPath, title: noQuizTitle)
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: quizzesList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Learned',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return quizzesList[index - 1].isLearned
                        ? QuizTile(quizzesList[index - 1])
                        : null;
                  },
                ),
              ),
            ],
          );
  }
}
