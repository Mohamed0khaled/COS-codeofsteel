import '../models/quiz_model.dart';
import '../models/question_model.dart';

/// Local data source for quizzes (static quiz data).
abstract class QuizLocalDataSource {
  /// Get a quiz by ID
  QuizModel? getQuizById(String quizId);

  /// Get all quizzes for a course
  List<QuizModel> getQuizzesByCourse(String courseId);

  /// Get all available quizzes
  List<QuizModel> getAllQuizzes();
}

/// Implementation of QuizLocalDataSource with static quiz data.
class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  // Static quiz data migrated from legacy Quizes.dart
  static final Map<String, QuizModel> _quizzes = {
    'cpp_quiz_1': QuizModel(
      id: 'cpp_quiz_1',
      title: 'C++ Basics - Quiz 1',
      courseId: 'cpp',
      timeLimit: 10,
      questions: const [
        QuestionModel(
          question: 'An IDE (Integrated Development Environment) is used to',
          options: [
            'Compile the code',
            'Debug the code',
            'Edit and compile the code',
            'Write comments'
          ],
          answerIndex: 2,
        ),
        QuestionModel(
          question: '#include <iostream> is a',
          options: [
            'Preprocessor directive',
            'Header file library',
            'Function declaration',
            'Compiler command'
          ],
          answerIndex: 1,
        ),
        QuestionModel(
          question:
              'int main(){\n    cout << "Hello World";\n    return 0;\n}\nWhat is the output of the following code?',
          options: ['Hello', 'World', 'Hello World!', 'Error'],
          answerIndex: 2,
        ),
        QuestionModel(
          question: 'In C++, each code statement must end with a semicolon (;)',
          options: ['True', 'False', 'Only for specific statements', 'Optional'],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'Which object is used to print text in C++?',
          options: ['cin', 'cout', 'printf', 'print'],
          answerIndex: 1,
        ),
        QuestionModel(
          question: 'What is the purpose of return 0; in the main function?',
          options: [
            'Outputs a value',
            'Ends the main function',
            'Declares a variable',
            'Starts the program execution'
          ],
          answerIndex: 1,
        ),
      ],
    ),
    'cpp_quiz_2': QuizModel(
      id: 'cpp_quiz_2',
      title: 'C++ Variables & Data Types - Quiz 2',
      courseId: 'cpp',
      timeLimit: 15,
      questions: const [
        QuestionModel(
          question: 'Which of these is a correct single-line comment in C++?',
          options: [
            '/* This is a comment */',
            '// This is a comment',
            '# This is a comment',
            '<!-- This is a comment -->'
          ],
          answerIndex: 1,
        ),
        QuestionModel(
          question: 'Which of the following is a valid way to declare an integer variable?',
          options: ['int x;', 'var x;', 'integer x;', 'int = x;'],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'How do you declare multiple variables of the same type in C++?',
          options: ['int x, y, z;', 'int x y z;', 'int x: y: z;', 'var x, y, z;'],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'Which of these is NOT allowed in variable naming in C++?',
          options: [
            'Starts with a digit',
            'Contains an underscore',
            'Uses uppercase letters',
            'Is descriptive'
          ],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'What is the correct way to declare a constant variable in C++?',
          options: [
            'const int x = 10;',
            'constant int x = 10;',
            'final int x = 10;',
            'static int x = 10;'
          ],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'What is the correct type for storing a single character in C++?',
          options: ['char', 'string', 'int', 'bool'],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'Which type is best for storing a number with a fractional part?',
          options: ['float', 'int', 'char', 'bool'],
          answerIndex: 0,
        ),
        QuestionModel(
          question:
              'What will happen if you try to use a reserved keyword (e.g., int) as a variable name?',
          options: [
            'Compile but crash later',
            'Throw an error',
            'The program will work fine',
            'Ignore the variable'
          ],
          answerIndex: 1,
        ),
        QuestionModel(
          question: 'What is the default value of an uninitialized variable in C++?',
          options: ['0', 'null', 'Undefined', 'Empty'],
          answerIndex: 2,
        ),
        QuestionModel(
          question: 'Which of these is NOT a valid C++ data type?',
          options: ['int', 'float', 'bool', 'real'],
          answerIndex: 3,
        ),
      ],
    ),
    'cpp_quiz_3': QuizModel(
      id: 'cpp_quiz_3',
      title: 'C++ Input/Output - Quiz 3',
      courseId: 'cpp',
      timeLimit: 10,
      questions: const [
        QuestionModel(
          question: 'Which of the following is used to take user input in C++?',
          options: ['cin', 'cout', 'input', 'scanf'],
          answerIndex: 0,
        ),
        QuestionModel(
          question:
              'What is the correct syntax to take user input for an integer variable `x` in C++?',
          options: ['cin >> x;', 'cin << x;', 'input >> x;', 'cout >> x;'],
          answerIndex: 0,
        ),
        QuestionModel(
          question: 'Which header file is required to use `cin` and `cout` in C++?',
          options: ['<stdio.h>', '<iostream>', '<input.h>', '<cstdio>'],
          answerIndex: 1,
        ),
      ],
    ),
  };

  @override
  QuizModel? getQuizById(String quizId) {
    return _quizzes[quizId];
  }

  @override
  List<QuizModel> getQuizzesByCourse(String courseId) {
    return _quizzes.values
        .where((quiz) => quiz.courseId == courseId)
        .toList();
  }

  @override
  List<QuizModel> getAllQuizzes() {
    return _quizzes.values.toList();
  }
}
