import 'package:flutter/material.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';

class DialogUtil {
  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFe9eeff),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: DeviceStyles.screenWidth(context) * 0.05,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: DeviceStyles.screenHeight(context) * 0.5,
          ),
          child: SingleChildScrollView(
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black,
                fontSize: DeviceStyles.screenWidth(context) * 0.035,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: DeviceStyles.screenWidth(context) * 0.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ButtonStyles.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ButtonStyles.borderradius(context)),
                ),
              ),
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: DeviceStyles.screenWidth(context) * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
