import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/view/screens/question_screen.dart';
import 'package:question_app/viewmodel/app_viewmodel.dart';
import 'package:question_app/viewmodel/navigator_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => NavigatorViewModel())
      ],
      child: MaterialApp(
        title: 'Loan Questionnaire',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const QuestionScreen(),
      ),
    );
  }
}
