import 'package:flutter/material.dart';
import 'package:supermarket_app/Utils/constants.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;
  const HomeCard({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: AppColors.PRIMARY_COLOR,
            ),
            Text(
              text1,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
