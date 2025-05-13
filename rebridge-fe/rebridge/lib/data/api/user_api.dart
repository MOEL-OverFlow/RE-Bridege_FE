import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:rebridge/data/api/register_api.dart';
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

  static Future<String> uploadAndSaveProfileImage(
      File imageFile, BuildContext context) async {
    try {
      // 1. 이미지 업로드
      final imageUrl = await RegisterApi.uploadImage(imageFile, context);
      print('이거에요? :$imageUrl');
      if (imageUrl == null) {
        DialogUtil.showCustomDialog(
          context,
          title: 'Upload Failed',
          content: 'Image upload failed. Please try again.',
        );
        return '';
      }

      // 2. 이미지 URL 저장
      final success = await updateProfileImage(imageUrl, context);
      if (success) {
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Profile image has been updated successfully.',
        );
        return imageUrl;
      } else {
        DialogUtil.showCustomDialog(
          context,
          title: 'Save Failed',
          content: 'Failed to save profile image. Please try again.',
        );
        return '';
      }
    } catch (e) {
      print('[UploadAndSaveProfileImage] 예외: $e');
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Unexpected error occurred during upload.',
      );
      return '';
    }
  }

  static Future<bool> updateProfileImage(
    String newImageUrl,
    BuildContext context,
  ) async {
    final headers = await _getHeaders();
    print('진짜 이건가? : $newImageUrl');
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/profileImage'),
      headers: headers,
      body: jsonEncode({"newImageUrl": newImageUrl}),
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Change completed',
        content: 'The Image has been successfully modified.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Image change failed. Please try again.',
      );
      return false;
    }
  }

  static Future<bool> updatePassword(
      String newPassword, BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/password'),
      headers: headers,
      body: jsonEncode({"newPassword": newPassword}),
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Change completed',
        content: 'The Password has been successfully modified.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Password change failed. Please try again.',
      );
      return false;
    }
  }

  static Future<bool> updateNation(String nation, BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/nation'),
      headers: headers,
      body: jsonEncode({"nation": nation}),
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Change completed',
        content: 'The Nation has been successfully modified.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Nation change failed. Please try again.',
      );
      return false;
    }
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
        title: 'Change completed',
        content: 'The name has been successfully modified.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Name change failed. Please try again.',
      );
      return false;
    }
  }

  static Future<bool> updateFields(
      String field1, String field2, BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/fields'),
      headers: headers,
      body: jsonEncode({"field1": field1, "field2": field2}),
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Change completed',
        content: 'Your industry of interest has been successfully changed.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Industry of industry change failed. Please try again.',
      );
      return false;
    }
  }

  static Future<bool> updateBirthDate(
      String birthDate, BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/birth-date'),
      headers: headers,
      body: jsonEncode({"birthDate": birthDate}),
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Change completed',
        content: 'Your birth has been successfully changed.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Birth change failed. Please try again.',
      );
      return false;
    }
  }

  static Future<bool> deactivateUser(BuildContext context) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('${Address.baseUrl}/me/deactivate'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Withdraw completed',
        content: 'Your membership withdrawal has been completed.',
      );
      return true;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Your membership withdrawal failed. Please try again.',
      );
      return false;
    }
  }

  static uploadImage(File imageFile) {}
}
