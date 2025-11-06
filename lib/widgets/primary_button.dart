import 'package:flutter/material.dart';
import 'package:triptact/core/constants/app_texts.dart';
import '../core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: isOutlined
          ? ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: AppColors.primary, width: 2),
              foregroundColor: AppColors.primary,
              textStyle: AppTextStyles.button.copyWith(
                color: AppColors.primary,
              ),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              textStyle: AppTextStyles.button,
            ),
      child: Text(text),
    );
  }
}
