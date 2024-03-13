import 'package:flutter/material.dart';
import 'package:urban_culture/view/app_screens.dart';
import 'package:urban_culture/view/home/home_page.dart';
import 'package:urban_culture/view/streaks/streaks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AppScreens(),
    );
  }
}
