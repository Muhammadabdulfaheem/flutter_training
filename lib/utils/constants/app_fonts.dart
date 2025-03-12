import 'package:flutter/material.dart';
import 'app_colors.dart'; // Import colors if needed

class AppFonts {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle mediumHeadingStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle = TextStyle(
    fontSize: 13,
    color: AppColors.textColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
