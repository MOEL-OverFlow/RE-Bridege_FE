import 'package:flutter/material.dart';
import 'device_styles.dart';

class LogoStyles {
  static double width(BuildContext context) =>
      DeviceStyles.screenWidth(context) * 0.4;

  static double height(BuildContext context) =>
      DeviceStyles.screenHeight(context) * 0.18;

  static const BoxFit fit = BoxFit.contain;
}
