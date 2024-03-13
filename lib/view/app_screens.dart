import 'package:flutter/material.dart';
import 'package:urban_culture/res/app_navigator.dart';
import 'package:urban_culture/res/constants.dart';

class AppScreens extends StatelessWidget {
  const AppScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: AppNavigator(),
    );
  }
}
