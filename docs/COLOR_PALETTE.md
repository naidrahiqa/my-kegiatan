# Color Palette Documentation

## Palette Overview

This app uses a carefully selected purple and pink color palette from [iPalettes](https://ipalettes.com/palette/extract/ntzndz01t8j4bfecvsl7f4).

## Color Definitions

### Primary Colors

- **Lavender Light** (#D3BDD3): rgb(211, 189, 211)
- **Purple Dark** (#3D2040): rgb(61, 32, 64) - Used for dark backgrounds
- **Blue Purple** (#8DA4C6): rgb(141, 164, 198) - Accent color
- **Purple Medium** (#6C3F72): rgb(108, 63, 114) - Main brand color
- **Purple Light** (#8F659C): rgb(143, 101, 156) - Secondary color

### Secondary Colors

- **Whiteish** (#F5EBEF): rgb(245, 235, 239) - Light backgrounds
- **Pink Light** (#EACFDF): rgb(234, 207, 223)
- **Mauve** (#B4898F): rgb(180, 137, 143)
- **Grey Purple** (#8A7C8D): rgb(138, 124, 141) - Text secondary
- **Brown Red** (#8C5C5C): rgb(140, 92, 92)

## Usage in App

### Theme Colors

- **Primary**: Purple Medium (#6C3F72)
- **Secondary**: Purple Light (#8F659C)
- **Accent**: Blue Purple (#8DA4C6)
- **Background (Dark)**: Purple Dark (#3D2040)
- **Background (Light)**: Whiteish (#F5EBEF)

### Functional Colors

- **Success**: Green (#4CAF50) - For completed tasks
- **Warning**: Orange (#FF9800) - For pending tasks
- **Error**: Red (#F44336) - For errors and delete actions
- **Info**: Blue Purple (#8DA4C6)

### Priority Colors

- **High Priority**: Brown Red (#8C5C5C)
- **Medium Priority**: Mauve (#B4898F)
- **Low Priority**: Blue Purple (#8DA4C6)

### Gradients

The app uses smooth gradients for a premium feel:

- **Primary Gradient**: Purple Medium → Purple Light
- **Accent Gradient**: Blue Purple → Purple Light
- **Dark Gradient**: Purple Dark → Purple Medium

## Design Philosophy

The color scheme creates a calming, professional atmosphere while maintaining visual interest through the purple-pink spectrum. This promotes productivity and focus while keeping the interface aesthetically pleasing.

## File Location

All colors are defined in: `/lib/utils/app_colors.dart`

## Implementation

To use these colors in your widgets:

```dart
import '../utils/app_colors.dart';

// Use colors
Container(
  color: AppColors.primary,
  // or use gradients
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
  ),
)
```
