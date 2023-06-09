import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzylite/core/constants/app_text_styles.dart';

import '../../core/constants/app_colors.dart';
import '../widgets/quizzes_lists/favorited_quizzes_list.dart';
import '../widgets/quizzes_lists/learned_quizzes_list.dart';
import '../widgets/quizzes_lists/new_quizzes_list.dart';
import 'edit_quiz_view.dart';

class DictionaryView extends ConsumerWidget {
  const DictionaryView({
    Key? key,
  }) : super(key: key);
  static const String widgetName = 'Dictionary';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            labelColor: AppColors.primary,
            tabs: [
              Text('Favorites', style: AppTextStyles.bodyLarge),
              Text('New', style: AppTextStyles.bodyLarge),
              Text('Learned', style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FavoritedQuizzesList(),
            NewQuizzesList(),
            LearnedQuizzesList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(EditQuizView.routeName);
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
