import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rebridge/shared/address.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken == null) throw Exception('Access token not found');
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  static Future<RegisterUser?> getUserInfo() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('${Address.baseUrl}/me/info'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RegisterUser(
        email: json['email'] ?? '',
        password: '',
        fullName: json['name'] ?? '',
        birth: json['birthDate'] ?? '',
        foreignNumber: json['foreignerNumber'] ?? '',
        nationality: json['nation'] ?? '',
        primaryIndustry: json['field1'] ?? '',
        secondaryIndustry: json['field2'] ?? '',
        imagePath: json['image'] ?? '',
      );
    } else {
      print('[UserApi] 사용자 정보 요청 실패: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> updateProfileImage(String newImageUrl) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/profileImage'),
      headers: headers,
      body: jsonEncode({"newImageUrl": newImageUrl}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> updatePassword(String newPassword) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/password'),
      headers: headers,
      body: jsonEncode({"newPassword": newPassword}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> updateNation(String nation) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/nation'),
      headers: headers,
      body: jsonEncode({"nation": nation}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> updateName(String name, BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/name'),
      headers: headers,
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: '이름 변경 완료',
        content: '이름이 성공적으로 수정되었습니다.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: '오류 발생',
        content: '이름 변경에 실패했습니다. 다시 시도해주세요.',
      );
      return false;
    }
  }

  static Future<bool> updateFields(String field1, String field2) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/fields'),
      headers: headers,
      body: jsonEncode({"field1": field1, "field2": field2}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> updateBirthDate(String birthDate) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/birth-date'),
      headers: headers,
      body: jsonEncode({"birthDate": birthDate}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deactivateUser() async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/deactivate'),
      headers: headers,
    );
    return response.statusCode == 200;
  }
}
