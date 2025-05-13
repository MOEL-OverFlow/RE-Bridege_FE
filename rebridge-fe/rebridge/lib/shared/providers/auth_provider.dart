import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebridge/data/api/user_api.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rebridge/shared/address.dart';

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

    print('[AuthNotifier] Initial login state: $state');
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        print('[AuthNotifier] No refresh token found');
        return false;
      }

      print('[AuthNotifier] Attempting to refresh token');
      print('[AuthNotifier] Current refresh token: $refreshToken');

      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/reissue'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );

      print('[AuthNotifier] Refresh response status: ${response.statusCode}');
      print('[AuthNotifier] Refresh response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final newAccessToken = responseData['accessToken'];
        final newRefreshToken = responseData['refreshToken'];

        print('[AuthNotifier] Token refresh successful');
        print('[AuthNotifier] New access token: $newAccessToken');
        print('[AuthNotifier] New refresh token: $newRefreshToken');

        await prefs.setString('accessToken', newAccessToken);
        await prefs.setString('refreshToken', newRefreshToken);
        return true;
      } else {
        print('[AuthNotifier] Token refresh failed: ${response.statusCode}');
        print('[AuthNotifier] Error response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('[AuthNotifier] Error refreshing token: $e');
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      print('[AuthNotifier] No access token found');
      return null;
    }

    // 토큰이 만료되었는지 확인하고 필요하면 갱신
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        print('[AuthNotifier] Invalid token format');
        return null;
      }

      final payload = jsonDecode(
        utf8.decode(
          base64Url.decode(
            base64Url.normalize(parts[1]),
          ),
        ),
      );

      final exp = payload['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (now >= exp) {
        print('[AuthNotifier] Token expired, attempting refresh');
        final refreshed = await _refreshToken();
        if (refreshed) {
          return prefs.getString('accessToken');
        } else {
          // 토큰 갱신 실패 시 로그아웃
          await logout();
          return null;
        }
      }
    } catch (e) {
      print('[AuthNotifier] Error checking token expiration: $e');
      return null;
    }

    return token;
    final user = await UserApi.getUserInfo();
    if (user != null) {
      ref.read(userRegisterProvider.notifier).state = user;
      print('[AuthNotifier] 사용자 정보 로딩 완료');
    } else {
      ref.read(userRegisterProvider.notifier).state = null;
      print('[AuthNotifier] 사용자 정보 로딩 실패');
    }
    print('[AuthNotifier] 초기 로그인 상태: $state');
  }

  Future<void> login({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    print(
        '[AuthNotifier] Storing tokens - Access: $accessToken, Refresh: $refreshToken');

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    state = true;

    final user = await UserApi.getUserInfo();
    if (user != null) {
      ref.read(userRegisterProvider.notifier).state = user;
      print('[AuthNotifier] User info loaded successfully');
    } else {
      ref.read(userRegisterProvider.notifier).state = null;
      print('[AuthNotifier] Failed to load user info');
    }

    print('[AuthNotifier] Login completed - isLoggedIn: $state');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    print('[AuthNotifier] Clearing tokens and logging out');

    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    state = false;

    ref.read(userRegisterProvider.notifier).state = null;
    print('[AuthNotifier] Logout completed - isLoggedIn: $state');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
}
