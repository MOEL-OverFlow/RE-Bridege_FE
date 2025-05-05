import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';

class RegisterApi {
  static Future<bool> sendCode(
      BuildContext context, String emailId, String eamilDomain) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final email = '$emailId@$eamilDomain';
    if (emailId.isEmpty || eamilDomain.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter your email',
      );
      return false;
    }
    if (!context.mounted) return false;
    DialogUtil.showCustomDialog(
      context,
      title: 'Send Success',
      content: 'Complete sending a verification code to that email',
    );
    print('Send code 요청 이메일: $email');
    return true;
  }

  static Future<bool> verifyCode(
      BuildContext context, String certificationCode) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (certificationCode.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(context,
          title: 'Error', content: 'Please enter Verification Code');
      return false;
    }
    if (!context.mounted) return false;
    DialogUtil.showCustomDialog(context,
        title: 'Success', content: 'Success Verification');
    print('Code : $certificationCode');
    return true;
  }

  static Future<bool> signup(BuildContext context, WidgetRef ref) async {
    await Future.delayed(const Duration(milliseconds: 500));

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
    print('Nationality: ${userData.nationality ?? "미입력"}');
    print('Primary Industry: ${userData.primaryIndustry ?? "미입력"}');
    print('Secondary Industry: ${userData.secondaryIndustry ?? "미입력"}');
    print('Image Path: ${userData.imagePath ?? "미선택"}');
    print('--------------------------------');

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
  }

  static verfiycode(BuildContext context, String certificationCode) {}
}
