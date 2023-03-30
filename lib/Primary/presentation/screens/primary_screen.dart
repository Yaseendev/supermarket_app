import 'package:flutter/material.dart';
import 'package:supermarket_app/Home/presentation/screens/home_screen.dart';
import '../widgets/app_nav_bar.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    Center(
      child: Text('2'),
    ),
    Center(
      child: Text('3'),
    ),
    Center(
      child: Text('4'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onSelect: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
