import 'package:flutter/material.dart';
import 'package:moneyku/screen/main_employee_screen.dart';
import 'package:moneyku/screen/main_screen.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import 'package:moneyku/screen/person/person_view_model.dart';
import 'package:moneyku/screen/sign/sign_screen.dart';
import 'package:moneyku/screen/sign/sign_view_model.dart';
import 'package:moneyku/screen/splash_screen.dart';
import 'package:moneyku/screen/task/task_view_model.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SignViewModel>(
        create: (context) => SignViewModel(),
      ),
      ChangeNotifierProvider<NotesViewModel>(
        create: (context) => NotesViewModel(),
      ),
      ChangeNotifierProvider<TaskViewModel>(
        create: (context) => TaskViewModel(),
      ),
      ChangeNotifierProvider<PersonViewModel>(
        create: (context) => PersonViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => const SplashScreen(),
      '/sign': (context) => SignScreen(),
      '/home': (context) => const MainScreen(),
      '/home-employee': (context) => const MainEmployeeScreen(),
    });
  }
}
