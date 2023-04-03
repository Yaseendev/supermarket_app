import 'package:flutter/material.dart';

class DealOfTheDaySection extends StatelessWidget {
  const DealOfTheDaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Deal Of The Day',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // BlocBuilder<DealBloc, DealState>(
        //   builder: (context, state) {
        //    if(state is DealLoaded)
        //    return DealOfTheDayCard(
        //     product: state.product,
        //    );
        //     return DealLoadingCard();
        //   },
        // ),
      ],
    );
  }
}
