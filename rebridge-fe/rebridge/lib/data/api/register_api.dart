import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/address.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class RegisterApi {
  static Future<bool> sendCode(
      BuildContext context, String emailId, String emailDomain) async {
    final email = '$emailId@$emailDomain';

    if (emailId.isEmpty || emailDomain.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter your email',
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/send-verification'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Send Success',
          content: 'Complete sending a verification code to that email',
        );
        print('Send code 요청 이메일: $email');
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Failed to send verification code.',
        );
        print('${response.body}');
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Network error: $e');
      return false;
    }
  }

  static Future<bool> verifyCode(BuildContext context, String certificationCode,
      String emailId, String emailDomain) async {
    final email = '$emailId@$emailDomain';

    if (certificationCode.isEmpty) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'Please enter Verification Code',
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'code': certificationCode,
        }),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Success Verification',
        );
        print('Code : $certificationCode');
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Verification failed\n${response.body}',
        );
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Network error: $e');
      return false;
    }
  }

  static Future<bool> signup(BuildContext context, WidgetRef ref) async {
    final userData = ref.read(userRegisterProvider);

    if (userData == null) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: 'No registration data found.',
      );
      return false;
    }

    String? imageUrl;
    if (userData.imagePath != null && userData.imagePath!.isNotEmpty) {
      final imageFile = File(userData.imagePath!);
      imageUrl = await uploadImage(imageFile, context);

      if (imageUrl == null) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Image upload failed.',
        );
        return false;
      }
    }

    final loginType = userData.password == null || userData.password.isEmpty
        ? 'GOOGLE'
        : 'LOCAL';

    final body = {
      "email": userData.email,
      "password": userData.password,
      "name": userData.fullName,
      "birthDate": userData.birth,
      "foreignerNumber": userData.foreignNumber,
      "nation": userData.nationality,
      "image": imageUrl ?? "",
      "industry1": userData.primaryIndustry,
      "industry2": userData.secondaryIndustry,
      "loginType": loginType,
    };

    try {
      final response = await http.post(
        Uri.parse('${Address.baseUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Success',
          content: 'Success Sign Up',
          onConfirm: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
        );
        return true;
      } else {
        if (!context.mounted) return false;
        DialogUtil.showCustomDialog(
          context,
          title: 'Error',
          content: 'Sign up failed.\n${response.body}',
        );
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      DialogUtil.showCustomDialog(
        context,
        title: 'Network Error',
        content: 'Could not connect to the server.',
      );
      print('Signup error: $e');
      return false;
    }
  }

  static Future<String?> uploadImage(
      File imageFile, BuildContext context) async {
    try {
      final uri = Uri.parse('${Address.baseUrl}/S3/upload');
      final request = http.MultipartRequest('POST', uri);
      final mimeType = lookupMimeType(imageFile.path)?.split('/');
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: mimeType != null
            ? MediaType(mimeType[0], mimeType[1])
            : MediaType('image', 'jpeg'),
      ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        print(json['imageUrl']);
        return json['imageUrl'];
      } else {
        print('[UploadImage] 실패: ${response.statusCode}, $responseBody');
        return null;
      }
    } catch (e) {
      print('[UploadImage] 예외: $e');
      return null;
    }
  }
}
