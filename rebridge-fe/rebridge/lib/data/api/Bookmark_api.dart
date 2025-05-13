import 'package:http/http.dart' as http;
import 'package:rebridge/shared/address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rebridge/data/api/JobPosting_api.dart';
import 'package:rebridge/shared/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

class BookmarkApi {
  static Future<List<JobPosting>> getMyBookmarks() async {
    try {
      final container = ProviderContainer();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        print('No authentication token found');
        throw Exception('No authentication token found');
      }

      print('Using token: $token'); // 토큰 값 확인용 로그

      final response = await http.get(
        Uri.parse('${Address.baseUrl}/bookmarks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}'); // 응답 상태 코드 확인용 로그
      print('Response body: ${response.body}'); // 응답 내용 확인용 로그

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => JobPosting.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        // 토큰이 만료되었거나 유효하지 않은 경우
        print('Token is invalid or expired');
        throw Exception('Your session has expired. Please log in again.');
      } else {
        print(
            'Failed to fetch bookmarks: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to fetch bookmarks: ${response.body}');
      }
    } catch (e) {
      print('Error fetching bookmarks: $e');
      throw Exception('Error fetching bookmarks: $e');
    }
  }

  static Future<bool> toggleBookmark(String jobPostingId) async {
    try {
      final container = ProviderContainer();
      final token =
          await container.read(authProvider.notifier).getAccessToken();

      if (token == null) {
        print('No authentication token found');
        return false;
      }

      print('Using token for toggle: $token'); // 토큰 값 확인용 로그

      final response = await http.post(
        Uri.parse('${Address.baseUrl}/bookmarks/$jobPostingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(
          'Toggle response status: ${response.statusCode}'); // 응답 상태 코드 확인용 로그
      print('Toggle response body: ${response.body}'); // 응답 내용 확인용 로그

      if (response.statusCode == 200) {
        print('Bookmark toggled successfully: ${response.body}');
        // 북마크 상태 변경 후 최신 데이터 가져오기
        await JobPostingApi.fetchJobPostings();
        return true;
      } else if (response.statusCode == 401) {
        // 토큰이 만료되었거나 유효하지 않은 경우
        print('Token is invalid or expired');
        return false;
      } else {
        print(
            'Failed to toggle bookmark: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
      return false;
    }
  }
}
