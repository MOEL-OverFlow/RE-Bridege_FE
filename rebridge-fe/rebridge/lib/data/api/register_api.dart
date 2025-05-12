import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/address.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  static Future<bool> sendCode(
      BuildContext context, String emailId, String emailDomain) async {
    final email = '$emailId@$emailDomain';

    if (emailId.isEmpty || emailDomain.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter your email',
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/send-verification'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Send Success',
          content: 'Complete sending a verification code to that email',
        );
        print('Send code 요청 이메일: $email');
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Failed to send verification code.',
        );
        print('${response.body}');
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Network error: $e');
      return false;
    }
  }

  static Future<bool> verifyCode(BuildContext context, String certificationCode,
      String emailId, String emailDomain) async {
    final email = '$emailId@$emailDomain';

    if (certificationCode.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter Verification Code',
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'code': certificationCode,
        }),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Success Verification',
        );
        print('Code : $certificationCode');
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Verification failed\n${response.body}',
        );
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Network error: $e');
      return false;
    }
  }

  static Future<bool> signup(BuildContext context, WidgetRef ref) async {
    final userData = ref.read(userRegisterProvider);

    if (userData == null) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'No registration data found.',
      );
      return false;
    }
    print('------ 회원가입 최종 데이터 ------');
    print('Email: ${userData.email}');
    print('Password: ${userData.password}');
    print('Full Name: ${userData.fullName}');
    print('Birth: ${userData.birth}');
    print('Foreigner Number: ${userData.foreignNumber}');
    print('Nationality: ${userData.nationality}');
    print('Primary Industry: ${userData.primaryIndustry}');
    print('Secondary Industry: ${userData.secondaryIndustry}');
    print('Image Path: ${userData.imagePath}');
    print('--------------------------------');

    final body = {
      "email": userData.email,
      "password": userData.password,
      "name": userData.fullName,
      "birthDate": userData.birth,
      "foreignerNumber": userData.foreignNumber,
      "nation": userData.nationality,
      "image": userData.imagePath,
      "industry1": userData.primaryIndustry,
      "industry2": userData.secondaryIndustry,
    };

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Success Sign Up',
          onConfirm: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
        );
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Sign up failed.\n${response.body}',
        );
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Signup error: $e');
      return false;
    }
  }
}
