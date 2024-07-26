import 'package:dio/dio.dart';
import 'package:flutter_app/models/result.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/api_routes.dart';

class AuthController {
  static Future<Result> register(
      String name, String email, String password) async {
    try {
      final response = await ApiService.post(
        ApiRoutes.registerUrl,
        {'name': name, 'email': email, 'password': password},
      );

      return Result(message: "testing", isSuccess: true);
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? AppStrings.anErrorOccurredTryAgain;

      final errors = e.response?.data['errors'];

      return Result(message: message, isSuccess: false, errors: errors);
    } catch (e) {
      return Result(
          message: AppStrings.anErrorOccurredTryAgain, isSuccess: false);
    }
  }
}
