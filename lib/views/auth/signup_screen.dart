// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/auth.dart';
import 'package:flutter_app/resources/app_routes.dart';
import 'package:flutter_app/resources/app_spacing.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/resources/app_styles.dart';
import 'package:flutter_app/utils/helper.dart';
import 'package:flutter_app/views/components/form/checkbox_input.dart';
import 'package:flutter_app/views/components/form/text_input.dart';
import 'package:flutter_app/views/components/ui/button.dart';

import '../../resources/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isLoading = false;
  bool hasAgree = false;

  final formkey = GlobalKey<FormState>();

  Map<String, dynamic> errors = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: Text(
            AppStrings.signUp,
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
        ),
        body: Form(
          key: formkey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextInput(
                error: errors['name']?.join(', '),
                isEnabled: !isLoading,
                isRequired: true,
                textInputType: TextInputType.name,
                focusNode: nameFocus,
                label: AppStrings.name,
                textEditingController: nameEditingController,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(emailFocus),
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.vertical(),
              TextInput(
                error: errors['email']?.join(', '),
                isEnabled: !isLoading,
                isRequired: true,
                textInputType: TextInputType.emailAddress,
                focusNode: emailFocus,
                label: AppStrings.emailAddress,
                textEditingController: emailEditingController,
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.vertical(),
              TextInput(
                error: errors['password']?.join(', '),
                isEnabled: !isLoading,
                isRequired: true,
                focusNode: passwordFocus,
                label: AppStrings.password,
                isPassword: true,
                textEditingController: passwordEditingController,
                textInputAction: TextInputAction.done,
              ),
              AppSpacing.vertical(),
              CheckboxInput(
                isEnabled: !isLoading,
                label: Text.rich(
                  TextSpan(
                    text: AppStrings.agreeText,
                    children: [
                      WidgetSpan(
                        child: AppSpacing.horizontal(size: 4),
                      ),
                      TextSpan(
                        text: AppStrings.termsAndPrivacy,
                        style: AppStyles.medium(
                            size: 14, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                value: false,
                onChanged: (value) => setState(() => hasAgree = value),
              ),
              AppSpacing.vertical(),
              ButtonComponent(
                isloading: isLoading,
                label: AppStrings.signUp,
                onPressed: signup,
              ),
              AppSpacing.vertical(size: 16),
              Text(
                AppStrings.orWith,
                style: AppStyles.bold(size: 14, color: AppColors.light20),
                textAlign: TextAlign.center,
              ),
              AppSpacing.vertical(size: 16),
              ButtonComponent(
                  type: ButtonType.light,
                  label: AppStrings.signUpWithGoogle,
                  icon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/images/google.png'),
                  ),
                  onPressed: () {}),
              AppSpacing.vertical(),
              Text.rich(
                textAlign: TextAlign.center,
                style: AppStyles.medium(size: 16),
                TextSpan(
                  text: AppStrings.alreadyHaveAnAccount,
                  style: AppStyles.medium(
                    color: AppColors.light20,
                  ),
                  children: [
                    WidgetSpan(
                      child: AppSpacing.horizontal(size: 4),
                    ),
                    TextSpan(
                      text: AppStrings.login,
                      style: AppStyles.medium(
                              size: 14, color: AppColors.primaryColor)
                          .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    setState(() => errors = {});
    FocusScope.of(context).unfocus();

    if (!formkey.currentState!.validate()) {
      return;
    }
    if (!hasAgree) {
      Helper.snackBar(context,
          message: AppStrings.inputIsRequired
              .replaceAll(':input', AppStrings.termsAndPrivacy),
          isSuccess: false);
      return;
    }

    setState(() {
      isLoading = true;
    });

    var result = await AuthController.register(
      nameEditingController.text.trim(),
      emailEditingController.text.trim(),
      passwordEditingController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (!result.isSuccess) {
      Helper.snackBar(context, message: result.message, isSuccess: false);
      if (result.errors != null) {
        errors = result.errors!;
      }
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamed(AppRoutes.verification);
  }
}
