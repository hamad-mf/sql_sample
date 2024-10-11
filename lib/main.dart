import 'package:flutter/material.dart';
import 'package:sql_sample/Controller/home_screen_controller.dart';
import 'package:sql_sample/View/Home%20Screen/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  HomeScreenController.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
