import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../shared/utils/dialog_util.dart';
import '../../shared/address.dart';

class FindApi {
  static Future<void> FindId(
    String name,
    String birth,
    String registrationNumber,
    String? country,
    BuildContext context,
  ) async {
    try {
      // Request body 생성 - 서버 형식에 맞게 수정
      final Map<String, dynamic> requestBody = {
        'foreignerNumber': registrationNumber,
        'name': name,
        'nation': country,
        'birthDate': birth,
      };

      // API 엔드포인트 설정
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/findId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // 성공 응답 처리 - 서버에서 반환된 이메일 표시
        final String email = response.body; // 서버에서 이메일 문자열을 직접 반환

        if (!context.mounted) return;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Your ID is: $email',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        // 에러 응답 처리
        if (!context.mounted) return;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Failed to find ID. Please try again.',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      // 예외 처리
      if (!context.mounted) return;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'An error occurred. Please try again.',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  static Future<void> FindPw(
    String email,
    String name,
    String birth,
    String foreignerNumber,
    BuildContext context,
  ) async {
    try {
      // Request body 생성
      final Map<String, dynamic> requestBody = {
        'email': email,
        'name': name,
        'foreignerNumber': foreignerNumber,
        'birthDate': birth,
      };

      // API 엔드포인트 설정
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/reset-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // 성공 응답 처리
        if (!context.mounted) return;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'A temporary password has been sent to your email.',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        // 에러 응답 처리
        if (!context.mounted) return;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: response.body, // 서버에서 반환한 에러 메시지 표시
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      // 예외 처리
      if (!context.mounted) return;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'An error occurred. Please try again.',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
