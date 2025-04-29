import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('isLoggedIn') ?? false;
    state = saved;

    print('[AuthNotifier] 초기 로그인 상태: $state');
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    state = true;

    print('[AuthNotifier] 로그인 완료 - isLoggedIn: $state');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    state = false;

    print('[AuthNotifier] 로그아웃 완료 - isLoggedIn: $state');
  }
}
