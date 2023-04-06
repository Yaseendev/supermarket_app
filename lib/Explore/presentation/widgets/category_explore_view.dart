import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supermarket_app/Home/blocs/category_bloc/category_bloc.dart';
import 'package:supermarket_app/Home/data/models/category.dart';
import 'package:supermarket_app/Home/presentation/widgets/loading/categories_laoding_view.dart';
import 'package:supermarket_app/Home/presentation/widgets/loading/category_loading_card.dart';
import 'package:supermarket_app/Home/presentation/widgets/lodaded/category_card.dart';

import 'category_tile.dart';
import 'product_explore_card.dart';

class CategoryExploreView extends StatefulWidget {
  final List<Category> categories;
  const CategoryExploreView({
    super.key,
    required this.categories,
  });

  @override
  State<CategoryExploreView> createState() => _CategoryExploreViewState();
}

class _CategoryExploreViewState extends State<CategoryExploreView> {
  late final List<bool> selectedCategories;

  @override
  void initState() {
    selectedCategories = List.filled(widget.categories.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              ...ListTile.divideTiles(
                context: context,
                tiles: List.generate(
                    widget.categories.length,
                    (index) => CategoryTile(
                          category: widget.categories[index],
                          selected: selectedCategories[index],
                          onSelect: () {
                            final int temp = selectedCategories
                                .indexWhere((element) => element);

                            if (temp != -1) {
                              selectedCategories[temp] = false;
                            }
                            context.read<CategoryBloc>().add(LoadCategory(
                                categoryId:
                                    widget.categories.elementAt(index).id));
                            setState(() {
                              selectedCategories[index] = true;
                            });
                          },
                        )),
              ),
            ],
          ),
        ),
        VerticalDivider(),
        Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoaded) {
                    return state.products.isEmpty
                        ? Center(
                            child: Text(
                              'There is no ${widget.categories.elementAt(selectedCategories.indexWhere((element) => element)).name} products yet',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 20,
                            children: state.products
                                .map((product) => ProductExploreCard(
                                      product: product,
                                    ))
                                .toList(),
                          );
                  } else if (state is CategoryLoading)
                    return CategoriesLoadingView();
                  return Container();
                },
              ),
            )),
      ],
    );
  }
}
