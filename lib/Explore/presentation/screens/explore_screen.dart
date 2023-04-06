import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supermarket_app/Home/blocs/categories_bloc/categories_bloc.dart';
import 'package:supermarket_app/Home/blocs/category_bloc/category_bloc.dart';
import 'package:supermarket_app/Shared/presentation/widgets/app_bar_widget.dart';
import 'package:supermarket_app/Utils/constants.dart';

import '../widgets/category_explore_view.dart';
import '../widgets/category_tile.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded)
          return BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(),
            child: CategoryExploreView(
              categories: state.categories,
            ),
          );
        return Center(
          child: SpinKitFadingCube(
            color: AppColors.PRIMARY_COLOR,
            size: 58,
          ),
        );
      },
    );
  }
}
