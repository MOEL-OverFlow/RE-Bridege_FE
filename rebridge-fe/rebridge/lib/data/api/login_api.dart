import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  static final List<User> _fakeUsers = [
    User(userId: '001', username: 'howeve18@gmail.com', password: '12345678'),
    User(userId: '002', username: 'butqqt5298@naver.com', password: '12345678'),
    User(
        userId: '003',
        username: 'minsoo030232@gmail.com',
        password: '12345678'),
    User(userId: '004', username: '5310009@naver.com', password: '12345678'),
    User(userId: '005', username: 'flutterdev', password: 'flutter123'),
  ];

  static Future<void> normallogin(
      BuildContext context, String id, String pw) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (id.isEmpty || pw.isEmpty) {
      // ✅ 아이디 또는 비밀번호가 비어있으면 얼럿 띄우고 종료
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('입력 오류'),
          content: const Text('아이디, 비밀번호를 모두 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        ),
      );
      return; // 바로 함수 종료
    }

    try {
      _fakeUsers.firstWhere(
        (u) => u.username == id && u.password == pw,
        orElse: () => throw Exception('아이디 또는 비밀번호가 일치하지 않습니다.'),
      );

      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 성공'),
          content: const Text('로그인에 성공하였습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        ),
      );
      context.go('/home');
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 실패'),
          content: const Text('아이디 또는 비밀번호가 일치하지 않습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}
