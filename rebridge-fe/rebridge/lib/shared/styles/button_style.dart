import 'package:flutter/material.dart';
import 'device_styles.dart';

class ButtonStyles {
  static double borderradius(BuildContext context) =>
      DeviceStyles.screenWidth(context) * 0.04;

  static double paddingheight(BuildContext context) =>
      DeviceStyles.screenHeight(context) * 0.02;

  static double paddingwidth(BuildContext context) =>
      DeviceStyles.screenWidth(context) * 0.04;

  static const Color buttonColor = Color(0xFF4D65E1);
}
