import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/address.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import '../../shared/utils/dialog_util.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rebridge/shared/providers/auth_provider.dart';

class User {
  final String userId;
  final String username;
  final String password;

  const User({
    required this.userId,
    required this.username,
    required this.password,
  });
}

class LoginApi {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> normallogin(
    BuildContext context,
    String id,
    String pw,
    WidgetRef ref,
  ) async {
    if (id.isEmpty || pw.isEmpty) {
      if (!context.mounted) return;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter both your ID and password.',
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/login/local'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': id,
          'password': pw,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final accessToken = responseData['accessToken'];
        final refreshToken = responseData['refreshToken'];

        await ref.read(authProvider.notifier).login(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );

        print('[LoginApi] 로그인 성공: $id');
        print('$accessToken');
        if (!context.mounted) return;

        DialogUtil.showCustomDialog(
          context,
          title: 'Login successful',
          content: 'Login successful.',
          onConfirm: () {
            Navigator.of(context).pop();
            context.go('/home');
          },
        );
      } else {
        print('[LoginApi] 로그인 실패: ${response.body}');
        if (!context.mounted) return;
        DialogUtil.showCustomDialog(
          context,
          title: 'Login failed',
          content: 'The ID or password does not match.',
        );
      }
    } catch (e) {
      print('[LoginApi] 로그인 에러: $e');
      if (!context.mounted) return;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Unable to connect to the server.',
      );
    }
  }

  static Future<void> googlelogin(BuildContext context, WidgetRef ref) async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('[GoogleLogin] ❌ 사용자가 로그인 취소함');
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/login/google'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'accessToken': accessToken, 'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final role = responseData['role'];
        final name = responseData['name'] ?? '';
        final email = responseData['email'] ?? '';

        print('[GoogleLogin] ✅ 응답 데이터: $responseData');

        if (!context.mounted) return;

        if (role == 'GUEST') {
          DialogUtil.showCustomDialog(
            context,
            title: 'Alert',
            content:
                'You signed up via Google.\nTo complete the process, please enter additional information.',
            onConfirm: () {
              Navigator.of(context).pop();

              ref.read(userRegisterProvider.notifier).state = RegisterUser(
                email: email,
                password: '',
                fullName: name,
                birth: '',
                foreignNumber: '',
                nationality: '',
                primaryIndustry: '',
                secondaryIndustry: '',
                imagePath: '',
              );
              print(email);
              print(name);
              context.push('/secondRegister');
            },
          );
        } else if (role == 'MEMBER') {
          DialogUtil.showCustomDialog(
            context,
            title: 'Welcome!',
            content: 'Welcome!',
            onConfirm: () {
              Navigator.of(context).pop();
              // ref.read(authProvider.notifier).login();
              context.push('/home');
            },
          );
        } else {
          DialogUtil.showCustomDialog(
            context,
            title: 'Error',
            content: '탈퇴한 회원입니다. 로그인할 수 없습니다.',
          );
        }
      } else {
        DialogUtil.showCustomDialog(
          context,
          title: 'Login Failed',
          content: '서버 오류로 로그인에 실패했습니다.',
        );
      }
    } catch (e) {
      print('[GoogleLogin] ❌ 예외 발생: $e');
      DialogUtil.showCustomDialog(
        context,
        title: 'Login Failed',
        content: 'Google login failed. Please try again.',
      );
    }
  }
}
