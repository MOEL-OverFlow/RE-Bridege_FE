import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          ref.read(authProvider.notifier).logout();

          context.go('/login');
          final isLoggedIn = ref.read(authProvider);
          print('현재 로그인 상태: $isLoggedIn');
        },
        child: const Text('로그아웃 하기'),
      )),
    );
  }
}
