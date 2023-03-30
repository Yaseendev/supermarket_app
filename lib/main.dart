import 'package:flutter/material.dart';
import 'package:supermarket_app/Primary/presentation/screens/primary_screen.dart';
import 'Utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supermarket App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.PRIMARY_SWATCH,
        scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
      ),
      home: const PrimaryScreen(),
    );
  }
}
