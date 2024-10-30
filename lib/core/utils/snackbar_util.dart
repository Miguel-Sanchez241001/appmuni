import 'package:flutter/material.dart';
import 'package:appmuni/theme/colors.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: AppColors.primary),
    ),
    backgroundColor: AppColors.white,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
