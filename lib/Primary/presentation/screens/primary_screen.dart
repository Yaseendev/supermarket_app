import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:supermarket_app/Cart/presentation/screens/cart_screen.dart';
import 'package:supermarket_app/Explore/presentation/screens/explore_screen.dart';
import 'package:supermarket_app/Home/blocs/categories_bloc/categories_bloc.dart';
import 'package:supermarket_app/Home/blocs/deal_bloc/deal_bloc.dart';
import 'package:supermarket_app/Home/blocs/popular_bloc/popular_bloc.dart';
import 'package:supermarket_app/Home/blocs/top_products_bloc/top_products_bloc.dart';
import 'package:supermarket_app/Home/presentation/screens/home_screen.dart';
import 'package:supermarket_app/Shared/blocs/location_bloc/location_bloc.dart';
import 'package:supermarket_app/Shared/presentation/widgets/app_bar_widget.dart';
import '../widgets/app_nav_bar.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  int currentIndex = 0;
  final CategoriesBloc categoriesBloc = CategoriesBloc()..add(LoadCategories());
  late final List<Widget> screens;
  final AddressesBloc addressesBloc = AddressesBloc()..add(GetAllAddresses());

  @override
  void initState() {
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider<DealBloc>(
            create: (context) => DealBloc()..add(FetchDeal()),
          ),
          BlocProvider<PopularBloc>(
            create: (context) => PopularBloc()..add(LoadMostPopular()),
          ),
          BlocProvider<TopProductsBloc>(
            create: (context) => TopProductsBloc()..add(FetchTopRated()),
          ),
        ],
        child: HomeScreen(),
      ),
      ExploreScreen(),
      CartScreen(
        onStart: () {
          setState(() {
            currentIndex = 0;
          });
        },
      ),
      Center(
        child: Text('4'),
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartBloc>().add(GetCart());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc()..add(DetectCurrentLocation()),
        ),
        BlocProvider<AddressesBloc>(
          create: (context) => addressesBloc,
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => categoriesBloc,
        ),
      ],
      child: Scaffold(
        appBar: currentIndex == 3 ? null : AppBarWidget(),
        body: screens[currentIndex],
        bottomNavigationBar: AppNavBar(
          currentIndex: currentIndex,
          onSelect: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
