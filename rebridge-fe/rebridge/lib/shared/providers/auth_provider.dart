import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebridge/data/api/user_api.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<bool> {
  final Ref ref;

  AuthNotifier(this.ref) : super(false) {
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('isLoggedIn') ?? false;
    state = saved;
    print('[AuthNotifier] 초기 로그인 상태: $state');
  }

  Future<void> login({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    state = true;

    final user = await UserApi.getUserInfo();
    if (user != null) {
      ref.read(userRegisterProvider.notifier).state = user;
      print('[AuthNotifier] 사용자 정보 로딩 완료');
    } else {
      ref.read(userRegisterProvider.notifier).state = null;
      print('[AuthNotifier] 사용자 정보 로딩 실패');
    }

    print('[AuthNotifier] 로그인 완료 - isLoggedIn: $state');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    state = false;

    ref.read(userRegisterProvider.notifier).state = null;
    print('[AuthNotifier] 로그아웃 완료 - isLoggedIn: $state');
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
}
