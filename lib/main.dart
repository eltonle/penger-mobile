import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_routes.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/views/auth/signup_screen.dart';
import 'package:flutter_app/views/auth/verification_screen.dart';
import 'package:flutter_app/views/onboarding/splash_screen.dart';
import 'package:flutter_app/views/onboarding/walkthrough_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
          fontFamily: 'Inter'),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.walkthrough: (context) => const WalkthroughScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.verification: (context) => const VerificationScreen(),
      },
    );
  }
}
