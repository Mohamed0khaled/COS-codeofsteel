class Quize {
  // Quize1
  final List<Map<String, dynamic>> questions_cppfull_1 = [
    {
      'question': 'An IDE (Integrated Development Environment) is used to',
      'options': [
        'Compile the code',
        'Debug the code',
        ' Edit and compile the code',
        'Write comments'
      ],
      'answerIndex': 2,
    },
    {
      'question': '#include <iostream> is a',
      'options': [
        'Preprocessor directive',
        'Header file library',
        ' Function declaration',
        'Compiler command'
      ],
      'answerIndex': 1,
    },
    {
      'question':
          'int main(){\n    cout << "Hello World";\n    return 0;\n}\nWhat is the output of the following code?',
      'options': ['Hello', 'World', 'Hello World!', 'Error'],
      'answerIndex': 2,
    },
    {
      'question': ' In C++, each code statement must end with a semicolon (;)',
      'options': ['True', 'False', 'Only for specific statements', 'Optional'],
      'answerIndex': 0,
    },
    {
      'question': 'Which object is used to print text in C++?',
      'options': ['cin', 'cout', 'printf', 'print'],
      'answerIndex': 1,
    },
    {
      'question': 'What is the purpose of return 0; in the main function?',
      'options': [
        'Outputs a value',
        'Ends the main function',
        ' Declares a variable',
        'Starts the program execution'
      ],
      'answerIndex': 1,
    },
  ];

  // Quize2
  final List<Map<String, dynamic>> questions_cppfull_2 = [
    {
      'question': 'Which of these is a correct single-line comment in C++?',
      'options': [
        '/* This is a comment */',
        '// This is a comment',
        '# This is a comment',
        '<!-- This is a comment -->'
      ],
      'answerIndex': 1,
    },
    {
      'question':
          'Which of the following is a valid way to declare an integer variable?',
      'options': ['int x;', 'var x;', 'integer x;', 'int = x;'],
      'answerIndex': 0,
    },
    {
      'question':
          'How do you declare multiple variables of the same type in C++?',
      'options': ['int x, y, z;', 'int x y z;', 'int x: y: z;', 'var x, y, z;'],
      'answerIndex': 0,
    },
    {
      'question': 'Which of these is NOT allowed in variable naming in C++?',
      'options': [
        'Starts with a digit',
        'Contains an underscore',
        'Uses uppercase letters',
        'Is descriptive'
      ],
      'answerIndex': 0,
    },
    {
      'question':
          'What is the correct way to declare a constant variable in C++?',
      'options': [
        'const int x = 10;',
        'constant int x = 10;',
        'final int x = 10;',
        'static int x = 10;'
      ],
      'answerIndex': 0,
    },
    {
      'question':
          'What is the correct type for storing a single character in C++?',
      'options': ['char', 'string', 'int', 'bool'],
      'answerIndex': 0,
    },
    {
      'question':
          'Which type is best for storing a number with a fractional part?',
      'options': ['float', 'int', 'char', 'bool'],
      'answerIndex': 0,
    },
    {
      'question':
          'What will happen if you try to use a reserved keyword (e.g., int) as a variable name?',
      'options': [
        'Compile but crash later',
        'Throw an error',
        'The program will work fine',
        'Ignore the variable'
      ],
      'answerIndex': 1,
    },
    {
      'question':
          'What is the default value of an uninitialized variable in C++?',
      'options': ['0', 'null', 'Undefined', 'Empty'],
      'answerIndex': 2,
    },
    {
      'question': 'Which of these is NOT a valid C++ data type?',
      'options': ['int', 'float', 'bool', 'real'],
      'answerIndex': 3,
    },
  ];

// Quize 3
  final List<Map<String, dynamic>> questions_cppfull_3 = [
    {
      'question': 'Which of the following is used to take user input in C++?',
      'options': ['cin', 'cout', 'input', 'scanf'],
      'answerIndex': 0,
    },
    {
      'question':
          'What is the correct syntax to take user input for an integer variable `x` in C++?',
      'options': ['cin >> x;', 'cin << x;', 'input >> x;', 'cout >> x;'],
      'answerIndex': 0,
    },
    {
      'question':
          'Which header file is required to use `cin` and `cout` in C++?',
      'options': ['<stdio.h>', '<iostream>', '<input.h>', '<cstdio>'],
      'answerIndex': 1,
    },
    {
      'question': 'Which of the following is NOT a valid data type in C++?',
      'options': ['int', 'float', 'string', 'real'],
      'answerIndex': 3,
    },
    {
      'question':
          'What is the size of the `int` data type in C++ on a 32-bit system?',
      'options': ['2 bytes', '4 bytes', '8 bytes', '1 byte'],
      'answerIndex': 1,
    },
    {
      'question': 'Which data type is used to store a single character in C++?',
      'options': ['char', 'string', 'int', 'float'],
      'answerIndex': 0,
    },
    {
      'question': 'What is the range of the `unsigned int` data type in C++?',
      'options': ['-128 to 127', '0 to 255', '0 to 65535', '0 to 4294967295'],
      'answerIndex': 3,
    },
    {
      'question': 'What is the size of the `double` data type in C++?',
      'options': ['4 bytes', '8 bytes', '16 bytes', '2 bytes'],
      'answerIndex': 1,
    },
    {
      'question':
          'Which of the following data types has the smallest size in C++?',
      'options': ['int', 'float', 'char', 'double'],
      'answerIndex': 2,
    },
    {
      'question': 'What is the size of the `bool` data type in C++?',
      'options': ['1 bit', '1 byte', '2 bytes', '4 bytes'],
      'answerIndex': 1,
    },
  ];

  // Quize 4
  final List<Map<String, dynamic>> questions_cppfull_4 = [
    {
      'question': 'What is the result of 5 + 3 in C++?',
      'options': ['8', '15', '2', '53'],
      'answerIndex': 0,
    },
    {
      'question': 'What does the operator += do in C++?',
      'options': ['Subtraction', 'Assignment', 'Multiplication', 'Division'],
      'answerIndex': 1,
    },
    {
      'question':
          'Which comparison operator checks if two values are equal in C++?',
      'options': ['==', '>=', '<=', '!='],
      'answerIndex': 0,
    },
    {
      'question': 'What is the result of (true && false) in C++?',
      'options': ['true', 'false', '1', '0'],
      'answerIndex': 1,
    },
    {
      'question': 'Which arithmetic operator is used for division in C++?',
      'options': ['%', '*', '+', '/'],
      'answerIndex': 3,
    },
    {
      'question':
          'What is the value of x after the expression x = 10 % 3; in C++?',
      'options': ['10', '1', '3', '0'],
      'answerIndex': 1,
    },
    {
      'question':
          'Which logical operator inverts the value of a boolean expression in C++?',
      'options': ['||', '&&', '!', '^'],
      'answerIndex': 2,
    },
    {
      'question': 'What does the expression x *= 2; do in C++?',
      'options': [
        'Divide x by 2',
        'Subtract 2 from x',
        'Multiply x by 2',
        'Add 2 to x'
      ],
      'answerIndex': 2,
    },
    {
      'question':
          'Which comparison operator checks if one value is less than another in C++?',
      'options': ['<=', '>=', '<', '>'],
      'answerIndex': 2,
    },
    {
      'question': 'What is the value of (true || false) in C++?',
      'options': ['true', 'false', '1', '0'],
      'answerIndex': 0,
    },
  ];
}
