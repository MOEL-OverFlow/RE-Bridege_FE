import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';

import '../../../shared/styles/logo_styles.dart';
import '../../../data/api/login_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  Future<void> _handleLogin() async {
    final id = _idController.text.trim();
    final pw = _pwController.text.trim();

    await LoginApi.normallogin(context, id, pw, ref);
    _idController.clear();
    _pwController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DeviceStyles.screenWidth(context) * 0.08,
              vertical: DeviceStyles.screenHeight(context) * 0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.04,
                ),
                Image.asset(
                  'assets/images/test_logo_image.png',
                  width: LogoStyles.width(context),
                  height: LogoStyles.height(context),
                  fit: LogoStyles.fit,
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                Text(
                  'Re:Bridge',
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.05,
                ),
                TextField(
                  controller: _idController,
                  enabled: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ButtonStyles.paddingwidth(context),
                        vertical: ButtonStyles.paddingheight(context)),
                  ),
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.02,
                ),
                TextField(
                  controller: _pwController,
                  obscureText: true,
                  enabled: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ButtonStyles.paddingwidth(context),
                        vertical: ButtonStyles.paddingheight(context)),
                  ),
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ButtonStyles.buttonColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: ButtonStyles.paddingwidth(context),
                          vertical: ButtonStyles.paddingheight(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ButtonStyles.borderradius(context)),
                      ),
                    ),
                    onPressed: _handleLogin,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: DeviceStyles.screenWidth(context) * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.02,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceStyles.screenWidth(context) * 0.02),
                      child: const Text(
                        'OR',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: ButtonStyles.paddingwidth(context),
                          vertical: ButtonStyles.paddingheight(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ButtonStyles.borderradius(context)),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    onPressed: () => LoginApi.googlelogin(context, ref),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.google,
                          size: 20,
                        ),
                        SizedBox(
                            width: DeviceStyles.screenWidth(context) * 0.03),
                        Text(
                          'Sign up/in Google',
                          style: TextStyle(
                            fontSize: DeviceStyles.screenWidth(context) * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go('/findId');
                      },
                      child: const Text(
                        'Find ID',
                        style: TextStyle(
                          color: Color(0xFF4D65E1),
                        ),
                      ),
                    ),
                    const Text(
                      '|',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/findPw');
                      },
                      child: const Text(
                        'Find PW',
                        style: TextStyle(
                          color: Color(0xFF4D65E1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don' 't you have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/membershipguide');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF4D65E1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
