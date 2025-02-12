// ignore: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import '../../root/splash_screen.dart';
import '../../root/route/route.dart';

var routes = (RouteSettings settings) {
  switch (settings.name) {
    case RootRoutes.initial:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  return null;
};
