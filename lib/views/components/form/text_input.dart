// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_spacing.dart';
import 'package:flutter_app/resources/app_strings.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? error;
  final TextEditingController textEditingController;
  final bool isPassword;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool isRequired;
  final bool isEnabled;

  const TextInput({
    Key? key,
    required this.label,
    this.error,
    this.isPassword = false,
    required this.textEditingController,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.textInputType,
    this.isRequired = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      enabled: widget.isEnabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (!widget.isRequired) return null;
        if (widget.isRequired == null || value!.isEmpty) {
          return AppStrings.inputIsRequired.replaceAll(':input', widget.label);
        }
        if (!widget.isPassword && value.trim().isEmpty) {
          return AppStrings.inputIsRequired.replaceAll(':input', widget.label);
        }
      },
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      obscureText: (widget.isPassword && !showPassword),
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.error,
        labelStyle: TextStyle(
          color: AppColors.light20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.light20.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.light20.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.light20,
                ),
              )
            : AppSpacing.empty(),
      ),
    );
  }

  void togglePassword() => setState(() {
        showPassword = !showPassword;
      });
}
