import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:supermarket_app/Account/blocs/account_bloc/account_bloc.dart';
import 'package:supermarket_app/Utils/constants.dart';
import '../widgets/account_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  String email = '';
  String password = '';
  bool passwordVisible = true;

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
          // context.read<CartBloc>().add(GetCart());
          // context.read<WishlistBloc>().add(GetWishList());
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   settings: RouteSettings(name: '/primary'),
          //   builder: (_) => MultiBlocProvider(
          //     providers: [
          //       BlocProvider<SearchBloc>(
          //         create: (context) => SearchBloc(),
          //       ),
          //     ],
          //     child: PrimaryScreen(),
          //   ),
          // ));
        } else if (state is AccountEmailSent) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.email_rounded,
                color: Colors.white,
              ),
              title: Text(
                'A reset password email has been sent to your email address',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
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
                  SizedBox(height: 16),
                  Image.asset(
                    AppImages.logoTransparent,
                    width: MediaQuery.of(context).size.width * .65,
                    height: MediaQuery.of(context).size.height * .2,
                    fit: BoxFit.cover,
                  ),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: 70,
                  //     foregroundImage: AssetImage(AppImages.logoTransparent),
                  //     backgroundColor:
                  //         Theme.of(context).scaffoldBackgroundColor,
                  //   ),
                  // ),
                  //SizedBox(height: 12),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              key: _emailKey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                hintText: 'E-mail',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              //autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              initialValue: email,
                              onChanged: (value) => email = value,
                              validator: (value) {
                                return !GetUtils.isEmail(value ?? '')
                                    ? 'Please enter a valid email'
                                    : null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                hintText: 'Password',
                                // labelText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: passwordVisible
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () => setState(() {
                                          passwordVisible = false;
                                        }),
                                      )
                                    : IconButton(
                                        onPressed: () => setState(() {
                                          passwordVisible = true;
                                        }),
                                        icon: const Icon(Icons.visibility_off),
                                      ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              maxLines: 1,
                              onChanged: (value) => password = value,
                              obscureText: passwordVisible,
                              validator: (value) {
                                return value!.trim().isNotEmpty
                                    ? value.trim().length > 6
                                        ? null
                                        : 'Password must be longer than 6 characters'
                                    : 'This field is required';
                              },
                            ),
                            SizedBox(height: 20),
                            BlocBuilder<AccountBloc, AccountState>(
                              builder: (context, state) {
                                return AccountButton(
                                  buttonState: state is AccountLoading
                                      ? ButtonState.loading
                                      : ButtonState.idle,
                                  label: 'Login',
                                  onPress: () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<AccountBloc>()
                                          .add(SingInEvent(
                                            email: email,
                                            password: password,
                                          ));
                                    }
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Forgot Password? ',
                                  children: [
                                    TextSpan(
                                      text: 'reset it',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Text('  Or Continue With  '),
                                Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      // context.read<AccountBloc>().add(LoginWithGoogleEvent());
                                    },
                                    icon:
                                        //     CircularProgressIndicator.adaptive(
                                        //   backgroundColor: Colors.white,
                                        // ),
                                        Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Google',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFFE6242E)),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(16)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      //context.read<AccountBloc>().add(LoginWithFacebookEvent());
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.facebookF,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Facebook',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF4267B2)),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(16)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                // Navigator.of(context)
                                //     .pushReplacement(MaterialPageRoute(
                                //         settings: RouteSettings(name: '/primary'),
                                //         builder: (_) => MultiBlocProvider(
                                //               providers: [
                                //                 BlocProvider<
                                //                     CategoriesBloc>(
                                //                   create: (context) =>
                                //                       CategoriesBloc(),
                                //                 ),
                                //                 BlocProvider<SearchBloc>(
                                //                   create: (context) =>
                                //                       SearchBloc(),
                                //                 ),
                                //               ],
                                //               child: PrimaryScreen(),
                                //             )));
                              },
                              child: Text('Continue as a visitor'),
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text.rich(
                              TextSpan(
                                text: 'Don\'t have an account?  ',
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SignupScreen()));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
