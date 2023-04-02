import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Account/blocs/account_bloc/account_bloc.dart';
import '../widgets/signup_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AccountNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                'No Internet Connection',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AccountLoggedIn) {
          // context.read<AddressBloc>().add(GetAllAddresses());
          // context.read<WishlistBloc>().add(GetWishList());
          // context.read<CartBloc>().add(GetCart());
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //    settings: RouteSettings(name: '/primary'),
          //     builder: (_) =>
          //             BlocProvider<SearchBloc>(
          //               create: (context) => SearchBloc(),
          //           child: PrimaryScreen(),
          //             ),
          //         ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    foregroundImage: AssetImage('assets/images/appLogo.jpg'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingupForm(),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context)
                            //     .pushReplacement(MaterialPageRoute(
                            //        settings: RouteSettings(name: '/primary'),
                            //         builder: (_) =>
                            //                 BlocProvider<SearchBloc>(
                            //                   create: (context) =>
                            //                       SearchBloc(),
                            //               child: PrimaryScreen(),
                            //             )));
                          },
                          child: Text('Continue as a visitor'),
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account?  ',
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => LoginScreen()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
