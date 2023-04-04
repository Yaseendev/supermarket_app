import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:supermarket_app/Home/blocs/categories_bloc/categories_bloc.dart';
import 'package:supermarket_app/Home/blocs/deal_bloc/deal_bloc.dart';
import 'package:supermarket_app/Home/blocs/popular_bloc/popular_bloc.dart';
import 'package:supermarket_app/Home/presentation/screens/home_screen.dart';
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

  @override
  void initState() {
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesBloc>(
            create: (context) => categoriesBloc,
          ),
          BlocProvider<AddressesBloc>(
            create: (context) => AddressesBloc()..add(GetAllAddresses()),
          ),
          BlocProvider<DealBloc>(
            create: (context) => DealBloc()..add(FetchDeal()),
          ),
          BlocProvider<PopularBloc>(
            create: (context) => PopularBloc()..add(LoadMostPopular()),
          ),
        ],
        child: HomeScreen(),
      ),
      Center(
        child: Text('2'),
      ),
      Center(
        child: Text('3'),
      ),
      Center(
        child: Text('4'),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onSelect: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
