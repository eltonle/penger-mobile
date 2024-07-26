import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_styles.dart';

class Helper {
  static snackBar(context, {required String message, bool isSuccess = true}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            isSuccess ? AppColors.primaryColor : Colors.red.shade900,
        content: Text(message, style: AppStyles.snackBar()),
      ),
    );
  }
}
