import 'package:flutter/material.dart';
import 'package:supermarket_app/Utils/constants.dart';

import 'home_card.dart';

class HomeCardsSection extends StatelessWidget {
  const HomeCardsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HomeCard(
            icon: Icons.undo_rounded,
            text1: 'In a hurry?',
            text2: 'Buy Agian',
          ),
          HomeCard(
            icon: Icons.favorite_rounded,
            text1: 'Shop using',
            text2: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
