import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Home/blocs/category_bloc/category_bloc.dart';
import 'package:supermarket_app/Home/data/models/category.dart';
import 'package:supermarket_app/Product/presentation/widgets/product_card.dart';
import 'package:supermarket_app/Product/presentation/widgets/product_loading_widget.dart';
import 'package:supermarket_app/Utils/constants.dart';
import '../widgets/loading/category_loading.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: isSearch && state is CategoryLoaded
                ? SizedBox(
                    height: 45,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color(0xFFF6F6F6),
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color(0xFFF6F6F6),
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        context
                            .read<CategoryBloc>()
                            .add(FillterProducts(searchTerm: value.trim()));
                      },
                    ),
                  )
                : Text(
                    widget.category.name,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
            leading: BackButton(
              color: AppColors.PRIMARY_COLOR,
              onPressed:
                  isSearch ? () => setState(() => isSearch = false) : null,
            ),
            actions: [
              isSearch || state is! CategoryLoaded
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isSearch = true;
                        });
                      },
                      icon: Icon(Icons.search_rounded),
                      color: AppColors.PRIMARY_COLOR,
                    ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () {
              final cBloc = context.read<CategoryBloc>()
                ..add(LoadCategory(categoryId: widget.category.id));
              return cBloc.stream.firstWhere((e) => e is CategoryLoaded);
            },
              child: state is CategoryLoaded
                  ? state.products.isEmpty
                      ? Center(
                          child: Text(
                            state.searchTerm != null
                                ? state.searchTerm!.isNotEmpty
                                    ? 'No result found'
                                    : 'There is no ${widget.category.name} products yet'
                                : 'There is no ${widget.category.name} products yet',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width / 430),
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.products[index]);
                        },
                      )
                : ProductLoadingWidget(),
          ),
        );
      },
    );
  }
}
