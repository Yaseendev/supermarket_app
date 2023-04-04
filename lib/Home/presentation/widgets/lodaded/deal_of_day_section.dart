import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Home/blocs/deal_bloc/deal_bloc.dart';

import '../loading/deal_of_day_loading_card.dart';
import 'deal_0f_day_card.dart';

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
        BlocBuilder<DealBloc, DealState>(
          builder: (context, state) {
           if(state is DealLoaded)
           return DealOfTheDayCard(
            product: state.product,
           );
            return DealLoadingCard();
          },
        ),
      ],
    );
  }
}
