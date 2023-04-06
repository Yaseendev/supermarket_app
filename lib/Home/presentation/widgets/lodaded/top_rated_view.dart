import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supermarket_app/Home/blocs/top_products_bloc/top_products_bloc.dart';
import '../loading/top_rated_loading_view.dart';
import 'home_item_card.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopProductsBloc, TopProductsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Rated',
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
            state is TopProductsLoaded
                ? StaggeredGrid.count(
                    crossAxisCount: 2,
                    children: state.products
                        .map((prod) => StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.21,
                              child: HomeItemCard(
                                product: prod,
                                width: double.maxFinite,
                              ),
                            ))
                        .toList(),
                  )
                : TopRatedLoadingView(),
          ],
        );
      },
    );
  }
}
