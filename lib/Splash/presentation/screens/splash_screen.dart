import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Account/blocs/account_bloc/account_bloc.dart';
import 'package:supermarket_app/Account/presentation/screens/login_screen.dart';
import 'package:supermarket_app/Splash/blocs/init_bloc/initroute_bloc.dart';
import '../widgets/splash_loading_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InitrouteBloc, InitrouteState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is InitrouteNoToken) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  settings: RouteSettings(name: '/login'),
                  builder: (ctx) {
                    return LoginScreen();
                  }));
            }
            if (state is InitrouteValidToken) {
              context.read<AccountBloc>().add(LoadUserProfileEvent());
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            // if (state is AccountLoggedIn) {
            //   context.read<AddressBloc>().add(GetAllAddresses());
            //   context.read<WishlistBloc>().add(GetWishList());
            //   context.read<CartBloc>().add(GetCart());
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       settings: RouteSettings(name: '/primary'),
            //       builder: (ctx) {
            //         return MultiBlocProvider(
            //           providers: [
            //             BlocProvider<SearchBloc>(
            //               create: (context) => SearchBloc(),
            //             ),
            //           ],
            //           child: PrimaryScreen(),
            //         );
            //       }));
            //}
          },
        ),
      ],
      child:
          Scaffold(
            backgroundColor: Colors.white,
             body: SplashLoadingWidget(),),
    );
  }
}
