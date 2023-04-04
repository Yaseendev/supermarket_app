import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:supermarket_app/Home/blocs/categories_bloc/categories_bloc.dart';
import 'package:supermarket_app/Home/blocs/deal_bloc/deal_bloc.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Search/data/repositories/search_repo.dart';
import 'package:supermarket_app/Utils/constants.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';
import '../widgets/loading/home_loading_view.dart';
import '../widgets/lodaded/banner_view.dart';
import '../widgets/lodaded/categories_view.dart';
import '../widgets/lodaded/deal_of_day_section.dart';
import '../widgets/lodaded/delivery_address_box.dart';
import '../widgets/lodaded/home_cards_section.dart';
import '../widgets/lodaded/most_popular_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHomeLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(AppImages.logoTransparent),
        title: TypeAheadField(
          hideOnLoading: true,
          minCharsForSuggestions: 1,
          textFieldConfiguration: TextFieldConfiguration(
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  width: 0,
                  color: Color(0xFFF6F6F6),
                  style: BorderStyle.none,
                ),
              ),
              constraints: BoxConstraints.expand(
                width: double.infinity,
                height: 42,
              ),
              prefixIcon: const Icon(Icons.search_rounded),
              hintText: 'Search for groceries and more',
              fillColor: Colors.white,
              filled: true,
            ),
            textAlignVertical: TextAlignVertical.bottom,
          ),
          autoFlipDirection: true,
          keepSuggestionsOnLoading: false,
          hideOnEmpty: true,
          hideOnError: true,
          suggestionsCallback: (pattern) async {
            List<Product>? resProducts;

            await locator.get<SearchRepository>().searchProducts(pattern).then(
                (value) => value.fold((l) => null, (r) => resProducts = r));
            return resProducts!;
          },
          itemBuilder: (context, suggestion) {
            //  return Container();
            return ListTile(
              horizontalTitleGap: 5,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: suggestion.images.first,
                  width: 70,
                  height: 80,
                  placeholder: (context, url) => Image.asset(
                    AppImages.placeholder,
                    width: 70,
                    height: 80,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.placeholder,
                    width: 70,
                    height: 80,
                  ),
                ),
              ),
              title: Text(suggestion.name),
              subtitle: Text('${suggestion.desc}'),
              trailing: Text('${suggestion.price} EGP'),
            );
          },
          onSuggestionSelected: (suggestion) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) => BlocProvider<ProductBloc>(
            //           create: (context) => ProductBloc(suggestion),
            //           child: ProductDetailsScreen(
            //             product: suggestion,
            //           ),
            //         )));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: DeliveryAddressBox(),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesLoading) {
                if(!isHomeLoading)
                setState(() {
                  isHomeLoading = true;
                });
              } else {
                if(isHomeLoading)
                setState(() {
                  isHomeLoading = false;
                });
              }
            },
          ),
          BlocListener<DealBloc, DealState>(
            listener: (context, state) {
              if (state is DealLoading) {
                if(!isHomeLoading)
                setState(() {
                  isHomeLoading = true;
                });
              } else {
                if(isHomeLoading)
                setState(() {
                  isHomeLoading = false;
                });
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () {
            context.read<CategoriesBloc>().add(LoadCategories());

            //     .stream
            //     .firstWhere((element) => false);
            return Future.delayed(Duration(seconds: 1));
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              if (isHomeLoading) HomeLoadingView(),
              if (!isHomeLoading) BannerView(),
              if (!isHomeLoading) HomeCardsSection(),
              if (!isHomeLoading) CategoriesView(),

              ///Deal of the day Section
              if (!isHomeLoading) DealOfTheDaySection(),

              ///Most Popular Section
              if(!isHomeLoading) MostPopularSection(),

              ///Top Rated Section
              //if(!isHomeLoading) TopRatedSection(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
