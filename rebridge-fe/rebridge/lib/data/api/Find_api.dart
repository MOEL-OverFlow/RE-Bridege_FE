import 'package:flutter/material.dart';
import '../../shared/utils/dialog_util.dart';

class FindApi {
  static Future<void> FindId(
    String name,
    String birth,
    String registrationNumber,
    String? country,
    BuildContext context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    print('========== [Find ID 요청 값] ==========');
    print('Name: $name');
    print('Birth: $birth');
    print('Registration Number: $registrationNumber');
    print('Country: $country');
    print('======================================');

    if (name.isEmpty ||
        birth.isEmpty ||
        registrationNumber.isEmpty ||
        country == null) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter all the information.',
      );
      return;
    }

    DialogUtil.showCustomDialog(
      context,
      title: 'Confirmation completed',
      content: 'The information you entered has been received successfully.',
      onConfirm: () {
        Navigator.of(context).pop();
      },
    );
  }

  static Future<void> FindPw(
    String email,
    String name,
    String birth,
    BuildContext context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    print('========== [Find PW 요청 값] ==========');
    print('Email : $email');
    print('Name: $name');
    print('Birth: $birth');
    print('======================================');

    if (email.isEmpty || name.isEmpty || birth.isEmpty) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter all the information.',
      );
      return;
    }

    DialogUtil.showCustomDialog(
      context,
      title: 'Confirmation completed',
      content: 'The information you entered has been received successfully.',
      onConfirm: () {
        Navigator.of(context).pop();
      },
    );
  }
}
