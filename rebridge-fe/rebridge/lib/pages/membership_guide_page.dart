import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';

class MembershipGuidePage extends StatelessWidget {
  const MembershipGuidePage({super.key});

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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go('/login');
                    },
                  ),
                ],
              ),
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
                child: Container(
                  padding:
                      EdgeInsets.all(DeviceStyles.screenHeight(context) * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                        ButtonStyles.borderradius(context)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                              color: Colors.black,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                    'Pursuant to the amendment of Article 24-2 of the Personal Information Protection Act, '
                                    'which took effect on August 7, 2014, the collection of foreign registration numbers is prohibited during the membership registration process on the Foreign Employment Management System website. '
                                    'While foreign registration numbers will not be stored, certain services will remain accessible. ',
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                              color: Colors.black,
                            ),
                            children: const [
                              TextSpan(
                                text: 'However, access to ',
                              ),
                              TextSpan(
                                text:
                                    'foreign national services and the customer support inquiry submission service ',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'will require separate identity verification following registration. ',
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                              color: Colors.black,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                    'For employers or authorized representatives seeking to use employer-related services, please visit the Work24 website (www.work24.go.kr).',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D65E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                    ),
                  ),
                  onPressed: () {
                    context.go('/agreeterms');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ButtonStyles.paddingheight(context),
                        horizontal: ButtonStyles.paddingwidth(context)),
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
