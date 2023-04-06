import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Home/blocs/categories_bloc/categories_bloc.dart';

import '../loading/categories_laoding_view.dart';
import '../loading/category_loading_card.dart';
import 'category_card.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: state is CategoriesLoaded
              ? Wrap(
                  spacing: 25,
                  runSpacing: 4,
                  children: state.categories
                      .map((cat) => CategoryCard(
                            category: cat,
                          ))
                      .toList(),
                )
              : CategoriesLoadingView(),
        );
      },
    );
  }
}
