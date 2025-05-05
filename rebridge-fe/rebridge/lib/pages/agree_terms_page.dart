import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import '../../shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';

class AgreeTermsPage extends StatefulWidget {
  const AgreeTermsPage({super.key});

  @override
  State<AgreeTermsPage> createState() => _AgreeTermsPageState();
}

class _AgreeTermsPageState extends State<AgreeTermsPage> {
  bool acceptAll = false;
  bool acceptTerms = false;
  bool acceptPersonalInfo = false;

  void _toggleAcceptAll(bool? value) {
    setState(() {
      acceptAll = value ?? false;
      acceptTerms = acceptAll;
      acceptPersonalInfo = acceptAll;
    });
  }

  void _toggleIndividual(String type, bool? value) {
    setState(() {
      if (type == 'terms') {
        acceptTerms = value ?? false;
      } else if (type == 'personal') {
        acceptPersonalInfo = value ?? false;
      }

      acceptAll = acceptTerms && acceptPersonalInfo;
    });
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
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go('/membershipguide');
                    },
                  ),
                ],
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Image.asset(
                'assets/images/register_logo_imgage.png',
                width: LogoStyles.width(context),
                height: LogoStyles.height(context),
                fit: LogoStyles.fit,
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Agree to the Terms and Conditions',
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Accept All',
                    style: TextStyle(
                      fontSize: DeviceStyles.screenWidth(context) * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(
                    value: acceptAll,
                    onChanged: _toggleAcceptAll,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Text(
                          'Terms and Conditions',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) => _toggleIndividual('terms', value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            'Consent to Collection and Use of Personal Information',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                  Checkbox(
                    value: acceptPersonalInfo,
                    onChanged: (value) => _toggleIndividual('personal', value),
                  ),
                ],
              ),
              const Spacer(),
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
                  onPressed: (acceptTerms && acceptPersonalInfo)
                      ? () {
                          context.go('/firstRegister');
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ButtonStyles.paddingwidth(context),
                        vertical: ButtonStyles.paddingheight(context)),
                    child: Text(
                      'I agree',
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
