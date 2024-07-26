import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_spacing.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/resources/app_styles.dart';

class CheckboxInput extends StatefulWidget {
  final bool value;
  final bool isEnabled;
  final Widget? label;
  final ValueChanged<bool> onChanged;

  const CheckboxInput({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            activeColor: AppColors.primaryColor,
            checkColor: Colors.white,
            side: BorderSide(color: AppColors.primaryColor),
            value: value,
            onChanged: widget.isEnabled
                ? (bool? newValue) {
                    setState(() => value = newValue!);
                    widget.onChanged(value);
                  }
                : null,
          ),
        ),
        if (widget.label != null) ...{
          AppSpacing.horizontal(size: 4),
          Expanded(
            child: widget.label!,
          ),
        }
      ],
    );
  }
}
