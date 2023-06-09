import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../viewmodel/module.dart';
import '../gif_widget.dart';
import '../quiz_tile.dart';

class NewQuizzesList extends ConsumerWidget {
  const NewQuizzesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String noQuizTitle = 'No New Quizzes';
    final quizzesListState = ref.watch(quizListState);
    final quizzesList = quizzesListState.quizList
        .where((quiz) => quiz.isLearned == false)
        .toList();

    return quizzesList.isEmpty
        ? const NoDataNotify(
            gifPath: AssetPaths.sleepingWithPillowPath,
            title: noQuizTitle,
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
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
                          'New',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return QuizTile(quizzesList[index - 1]);
                  },
                ),
              ),
            ],
          );
  }
}
