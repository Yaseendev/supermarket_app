import 'package:flutter/material.dart';
import 'package:supermarket_app/Utils/constants.dart';

import '../widgets/banner_view.dart';
import '../widgets/categories_view.dart';
import '../widgets/home_cards_section.dart';

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
            HomeCardsSection(),
            CategoriesView(),
             ///Deal of the day Section
              //DealOfTheDaySection(),

              ///Most Popular Section
              //MostPopularSection(),

              ///Top Rated Section
              //TopRatedSection(),

              SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
