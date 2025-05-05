import 'package:flutter/material.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';

class DialogCancelUtil {
  static Future<bool> showCancelCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFe9eeff),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: DeviceStyles.screenWidth(context) * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: DeviceStyles.screenWidth(context) * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: DeviceStyles.screenWidth(context) * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceStyles.screenWidth(context) * 0.03,
                    ),
                  ),
                ),
              ),
              SizedBox(width: DeviceStyles.screenWidth(context) * 0.04),
              SizedBox(
                width: DeviceStyles.screenWidth(context) * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D65E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceStyles.screenWidth(context) * 0.03,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
