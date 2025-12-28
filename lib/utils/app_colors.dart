import 'package:flutter/material.dart';

/// App Color Palette
/// Based on the selected custom palette
class AppColors {
  // Primary Colors
  static const Color lavenderLight = Color(0xFFD3BDD3);
  static const Color purpleDark = Color(0xFF3D2040);
  static const Color bluePurple = Color(0xFF8DA4C6);
  static const Color purpleMedium = Color(0xFF6C3F72);
  static const Color purpleLight = Color(0xFF8F659C);
  
  // Secondary Colors
  static const Color whiteish = Color(0xFFF5EBEF);
  static const Color pinkLight = Color(0xFFEACFDF);
  static const Color mauve = Color(0xFFB4898F);
  static const Color greyPurple = Color(0xFF8A7C8D);
  static const Color brownRed = Color(0xFF8C5C5C);
  
  // Functional Colors (based on palette)
  static const Color primary = purpleMedium; // Main brand color
  static const Color secondary = purpleLight;
  static const Color accent = bluePurple;
  static const Color background = purpleDark;
  static const Color surface = whiteish;
  static const Color textPrimary = purpleDark;
  static const Color textSecondary = greyPurple;
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = bluePurple;
  
  // Priority Colors
  static const Color priorityHigh = brownRed;
  static const Color priorityMedium = mauve;
  static const Color priorityLow = bluePurple;
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purpleMedium, purpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [bluePurple, purpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [purpleDark, purpleMedium],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
