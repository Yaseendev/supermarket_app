import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supermarket_app/Utils/constants.dart';

class SplashLoadingWidget extends StatelessWidget {
  const SplashLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AppImages.logo,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .4,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 50),
        SpinKitWanderingCubes(
          color: AppColors.PRIMARY_COLOR,
          size: 60,
        ),
      ],
    );
  }
}
