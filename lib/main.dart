import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Primary/presentation/screens/primary_screen.dart';
import 'Account/blocs/account_bloc/account_bloc.dart';
import 'Splash/blocs/init_bloc/initroute_bloc.dart';
import 'Splash/presentation/screens/splash_screen.dart';
import 'Utils/constants.dart';
import 'Utils/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await locatorsSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(),
          ),
          BlocProvider<InitrouteBloc>(
            create: (context) => InitrouteBloc()..add(UserCheckEvent()),
          ),
      ],
      child: MaterialApp(
        title: 'Supermarket App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.PRIMARY_SWATCH,
          scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
        ),
        home: const SplashScreen(),
        //const PrimaryScreen(),
      ),
    );
  }
}
