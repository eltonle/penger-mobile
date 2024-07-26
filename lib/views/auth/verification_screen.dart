import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/resources/app_styles.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(
        AppStrings.verification,
        style: AppStyles.appTitle(),
        textAlign: TextAlign.center,
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      centerTitle: true,
    ));
  }
}
