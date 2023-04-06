import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Home/blocs/category_bloc/category_bloc.dart';
import 'package:supermarket_app/Home/data/models/category.dart';
import 'package:supermarket_app/Home/presentation/screens/category_screen.dart';
import 'package:supermarket_app/Utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc()..add(LoadCategory(categoryId: category.id)),
                child: CategoryScreen(category: category),
              ))),
      child: SizedBox(
        width: 52,
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              foregroundImage: NetworkImage(category.imgUrl),
              //onForegroundImageError: ,
              backgroundImage: AssetImage(AppImages.placeholder2),
              //child: Icon(FontAwesomeIcons.shop),
            ),
            // SizedBox(height: 8),
            Text(
              category.name,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
