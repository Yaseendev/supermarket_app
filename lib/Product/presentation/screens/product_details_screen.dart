import 'package:banner_carousel/banner_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supermarket_app/Cart/blocs/cart_item_bloc/cart_item_bloc.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Product/product_bloc/product_bloc.dart';
import 'package:supermarket_app/Utils/constants.dart';
import 'package:supermarket_app/Wishlist/bloc/wishlist_bloc.dart';
import '../widgets/cart_buttons_section.dart';
import '../widgets/description_section.dart';
import '../widgets/rating_loading.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ScrollController _scrollController;
  int qty = 1;
  bool get _isSliverAppBarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * .34) - kToolbarHeight;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              pinned: true,

              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: _isSliverAppBarCollapsed
                  ? Text(
                      widget.product.name,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    )
                  : null,

              leading: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(
                      CircleBorder(),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFF5F5F5)),
                    alignment: Alignment.centerLeft,
                    // /padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 26,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * .34,
              //backgroundColor: AppColors.PRIMARY_COLOR,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: BannerCarousel.fullScreen(
                        animation: true,
                        height: MediaQuery.of(context).size.height * .34,
                        activeColor: widget.product.images.length <= 1
                            ? Colors.transparent
                            : AppColors.PRIMARY_COLOR,
                        customizedBanners: [
                          ...widget.product.images.map((e) =>
                              CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: e,
                                height: MediaQuery.of(context).size.height * .5,
                                width: double.infinity,
                                placeholder: (context, url) => Image.asset(
                                  AppImages.placeholder,
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  width: double.infinity,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  AppImages.placeholder,
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  width: double.infinity,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 10,
                      child: BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          final isWishlisted = state is WishlistLoaded &&
                              state.products.any(
                                  (element) => element.id == widget.product.id);
                          return ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(
                                CircleBorder(),
                              ),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(8)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              context.read<WishlistBloc>().add(isWishlisted
                                  ? RemoveFromlist(widget.product.id)
                                  : AddToWishlist(widget.product));
                            },
                            child: state is WishlistLoading
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Icon(
                                    isWishlisted
                                        ? Icons.favorite_rounded
                                        : widget.product.isFav
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_outline_rounded,
                                    size: 35,
                                    color: isWishlisted
                                        ? AppColors.PRIMARY_COLOR
                                        : widget.product.isFav
                                            ? AppColors.PRIMARY_COLOR
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                DescriptionSection(
                  product: widget.product,
                ),
                Row(
                  children: [
                    Card(
                      margin: EdgeInsets.only(left: 12, bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (qty > 1) {
                                  setState(() {
                                    --qty;
                                  });
                                }
                              },
                              icon: Icon(Icons.minimize_rounded),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 16),
                              color: AppColors.PRIMARY_COLOR,
                              iconSize: 30,
                              disabledColor: Color(0xFFF5A7AB),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$qty',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  ++qty;
                                });
                              },
                              icon: Icon(Icons.add),
                              alignment: Alignment.center,
                              //padding:const EdgeInsets.symmetric(vertical: 6),
                              color: AppColors.PRIMARY_COLOR,
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    'Rate The Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductReady) {
                        return RatingBar.builder(
                          minRating: .5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {
                            print(value);
                            context.read<ProductBloc>().add(RateProduct(
                                rate: value, product: widget.product));
                          },
                          //itemSize: 20,
                          allowHalfRating: true,
                          initialRating: 0,
                        );
                      }
                      return RatingLoading();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocProvider<CartItemBloc>(
          create: (context) => CartItemBloc(),
          child: CartButtonsSection(
            onPress: (ctx) {
              ctx.read<CartItemBloc>().add(AddItemToCart(
                      item: CartItem(
                    product: widget.product,
                    quantity: qty,
                  )));
            },
          ),
        ),
      ),
    );
  }
}
