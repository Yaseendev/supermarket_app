import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_app/Utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(AppImages.logoTransparent),
        title: TextField(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: ListTile(
            horizontalTitleGap: 0,
            //contentPadding: ,
            leading: const Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: Text(
              'Deliver To:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: TextButton(
              child: Text('Change'),
              onPressed: () {},
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            BannerView(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.undo_rounded,
                            size: 45,
                          ),
                          Text('In a hurry?'),
                          Text('Buy Agian'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerView extends StatelessWidget {
  const BannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BannerCarousel(
      margin: EdgeInsets.zero,

      banners: [
        BannerModel(
          id: '1',
          imagePath:
              'https://img.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg?w=2000',
        ),
        BannerModel(
          id: '2',
          imagePath:
              'https://static.vecteezy.com/system/resources/thumbnails/001/381/216/small/special-offer-sale-banner-with-megaphone-free-vector.jpg',
        ),
        BannerModel(
          id: '3',
          imagePath:
              'https://img.freepik.com/premium-vector/special-offer-sale-discount-banner_180786-46.jpg',
        ),
      ],
      // customizedIndicators: IndicatorModel.animation(
      //     width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
      height: 125,
      activeColor: AppColors.PRIMARY_COLOR,
      //disableColor: AppColors.BACKGROUND_COLOR,
      animation: true,
      borderRadius: 12,
      viewportFraction: .9,
      width: MediaQuery.of(context).size.width,
      indicatorBottom: false,
      spaceBetween: 5,
    );
  }
}
