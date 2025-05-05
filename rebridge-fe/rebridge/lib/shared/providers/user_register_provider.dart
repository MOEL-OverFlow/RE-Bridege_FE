import 'package:flutter_riverpod/flutter_riverpod.dart';

// 회원가입 정보 모델
class RegisterUser {
  final String email;
  final String password;
  final String fullName;
  final String birth;
  final String foreignNumber;

  // 추가된 필드
  final String? nationality;
  final String? primaryIndustry;
  final String? secondaryIndustry;
  final String? imagePath;

  RegisterUser({
    required this.email,
    required this.password,
    required this.fullName,
    required this.birth,
    required this.foreignNumber,
    this.nationality,
    this.primaryIndustry,
    this.secondaryIndustry,
    this.imagePath,
  });

  // 복사해서 새로운 객체 생성하는 메서드 (변경 시 사용하면 좋음)
  RegisterUser copyWith({
    String? email,
    String? password,
    String? fullName,
    String? birth,
    String? foreignNumber,
    String? nationality,
    String? primaryIndustry,
    String? secondaryIndustry,
    String? imagePath,
  }) {
    return RegisterUser(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      birth: birth ?? this.birth,
      foreignNumber: foreignNumber ?? this.foreignNumber,
      nationality: nationality ?? this.nationality,
      primaryIndustry: primaryIndustry ?? this.primaryIndustry,
      secondaryIndustry: secondaryIndustry ?? this.secondaryIndustry,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

// Provider
final userRegisterProvider = StateProvider<RegisterUser?>((ref) => null);
