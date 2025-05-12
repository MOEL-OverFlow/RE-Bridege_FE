import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/styles/logo_styles.dart';

class MembershipGuide2Page extends StatelessWidget {
  const MembershipGuide2Page({super.key});

  Widget _buildStepCard(BuildContext context, int step, IconData icon,
      String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ButtonStyles.paddingwidth(context),
          vertical: ButtonStyles.paddingheight(context)),
      padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ButtonStyles.borderradius(context)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF4D65E1),
            radius: 12,
            child: Text(
              '$step',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: DeviceStyles.screenWidth(context) * 0.035),
            ),
          ),
          SizedBox(width: DeviceStyles.screenWidth(context) * 0.015),
          Icon(icon, color: Colors.black54),
          SizedBox(width: DeviceStyles.screenWidth(context) * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DeviceStyles.screenWidth(context) * 0.035,
                  ),
                ),
                SizedBox(width: DeviceStyles.screenHeight(context) * 0.005),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.03,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.08,
            vertical: DeviceStyles.screenHeight(context) * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
              Image.asset(
                'assets/images/register_logo_imgage.png',
                width: LogoStyles.width(context),
                height: LogoStyles.height(context),
                fit: LogoStyles.fit,
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
              Text(
                'Membership Registration Guide',
                style: TextStyle(
                  fontSize: DeviceStyles.screenWidth(context) * 0.045,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildStepCard(
                        context,
                        1,
                        Icons.info_outline,
                        'Membership Registration Guide',
                        'General information regarding membership registration.',
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: DeviceStyles.screenWidth(context) * 0.04),
                      _buildStepCard(
                        context,
                        2,
                        Icons.description_outlined,
                        'Agreement to Terms and Conditions',
                        'You must agree to all membership terms and conditions to proceed to the next step.',
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: DeviceStyles.screenWidth(context) * 0.04),
                      _buildStepCard(
                        context,
                        3,
                        Icons.person_outline,
                        'Member Information Registration',
                        'You must complete the required registration form for membership.',
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: DeviceStyles.screenWidth(context) * 0.04),
                      _buildStepCard(
                        context,
                        4,
                        Icons.check_circle_outline,
                        'Membership Registration Complete',
                        'Your registration is complete after finishing all the required steps.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ButtonStyles.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ButtonStyles.borderradius(context),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.push('/agreeterms');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ButtonStyles.paddingheight(context),
                      horizontal: ButtonStyles.paddingwidth(context),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: DeviceStyles.screenWidth(context) * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
