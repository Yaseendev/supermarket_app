import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supermarket_app/Utils/constants.dart';

class NoCartItemsView extends StatelessWidget {
  final VoidCallback onStartPressed;
  const NoCartItemsView({
    super.key,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppImages.emptyCart,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * .42,
            width: MediaQuery.of(context).size.width * .8,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Looking for something?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add your wanted items to your cart',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: onStartPressed,
          child: Text(
            'Start Shoping',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
