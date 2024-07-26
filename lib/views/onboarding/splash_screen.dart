import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_routes.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/resources/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: AppStyles.titlex(size: 66, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    initApp();
    // TODO: implement initState
    super.initState();
  }

  void initApp() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        AppRoutes.walkthrough,
      ),
    );
  }
}
