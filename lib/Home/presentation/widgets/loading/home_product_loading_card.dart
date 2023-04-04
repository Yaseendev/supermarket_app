import 'package:flutter/material.dart';

class HomeProductLoadingCard extends StatelessWidget {
  const HomeProductLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 120,
        height: 160,
      ),
    );
  }
}
