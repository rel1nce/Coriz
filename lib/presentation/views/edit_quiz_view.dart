import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shortid/shortid.dart';

import '../viewmodel/module.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/quiz/quiz.dart';

class EditQuizView extends ConsumerStatefulWidget {
  const EditQuizView({super.key, this.quizId});

  static const routeName = '/edit';
  final String? quizId;

  @override
  ConsumerState<EditQuizView> createState() => _EditQuizViewState();
}

class _EditQuizViewState extends ConsumerState<EditQuizView> {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _conceptController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final model = ref.read(quizListModel);

  @override
  void initState() {
    super.initState();

    if (widget.quizId != null) {
      model.get(widget.quizId!).then((qz) {
        if (qz != null) {
          _wordController.text = qz.word;
          _conceptController.text = qz.concept;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNewQuiz = widget.quizId == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewQuiz ? 'New Quiz!' : 'Edit Quiz'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: TextFormField(
                controller: _wordController,
                validator: isCorrectInput,
                decoration: InputDecoration(
                  hintText: isNewQuiz ? 'Enter new word' : 'Enter edited word',
                ),
              ),
            ),
            IconButton(
              //TODO: add API functionality
              onPressed: () {},
              icon: const Icon(
                Icons.transform,
                size: 30,
                color: AppColors.secondary,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.lightGrey,
                padding: const EdgeInsets.all(15.0),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: TextFormField(
                controller: _conceptController,
                validator: isCorrectInput,
                decoration: InputDecoration(
                  hintText:
                      isNewQuiz ? 'Enter new concept' : 'Enter edited concept',
                  suffixIcon: const Icon(Icons.question_answer),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (isNewQuiz) {
                    Quiz newQuiz = Quiz(
                      id: shortid.generate(),
                      word: _wordController.text,
                      concept: _conceptController.text,
                      isLearned: false,
                      isFavorite: false,
                    );
                    model.save(newQuiz);
                  } else {
                    model.get(widget.quizId!).then((qz) {
                      if (qz != null) {
                        model.save(qz.copyWith(
                          word: _wordController.text,
                          concept: _conceptController.text,
                        ));
                      }
                    });
                  }
                  if (context.canPop()) {
                    context.pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGrey,
                foregroundColor: AppColors.secondary,
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  String? isCorrectInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, fill the form.';
    } else {
      return null;
    }
  }
}
