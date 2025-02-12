import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import '../configs/app_configs.dart';
import '../shared/analytics/analytics_service.dart';
import '../shared/utils/colors.dart';
import '../shared/utils/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool isFirstTime;

  @override
  void initState() {
    GetIt.I<AnalyticService>().addEvent(name: "App_Launched");

    isUserFirstTime().then((value) => isFirstTime = value);
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next screen

        // GetIt.I.get<NavigationService>().to(
        //     routeName: isFirstTime ? AuthRoutes.welcomePage : RootRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> isUserFirstTime() async {
    var firstTime = await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    return firstTime == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: Center(
            child: Lottie.asset(
          'assets/json/splash_screen.json',
          controller: _animationController,
        )));
  }
}
