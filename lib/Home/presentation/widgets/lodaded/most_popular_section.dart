import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Home/blocs/popular_bloc/popular_bloc.dart';

import '../loading/home_products_loading_view.dart';
import 'home_products_scection.dart';

class MostPopularSection extends StatelessWidget {
  const MostPopularSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Most Popular',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  onPressed: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => RestaurantScreen()));
                  },
                  label: const Text('See All'),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<PopularBloc, PopularState>(
          builder: (context, state) {
            if(state is PopularLoaded)
            return HomeProductsSection(
              products: state.products,
            );
            return HomeProductsLoadingView();
          },
        ),
      ],
    );
  }
}
