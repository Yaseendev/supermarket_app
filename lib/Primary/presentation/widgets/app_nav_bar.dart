import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onSelect;
  const AppNavBar({super.key,
  required this.currentIndex,
  required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onSelect,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      );
  }
}
