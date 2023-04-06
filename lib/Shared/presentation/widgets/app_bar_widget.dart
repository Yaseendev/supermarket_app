import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:supermarket_app/Home/presentation/widgets/lodaded/delivery_address_box.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Search/data/repositories/search_repo.dart';
import 'package:supermarket_app/Utils/constants.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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

          await locator
              .get<SearchRepository>()
              .searchProducts(pattern)
              .then((value) => value.fold((l) => null, (r) => resProducts = r));
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}