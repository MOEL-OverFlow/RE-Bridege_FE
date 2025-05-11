import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUser {
  final String email;
  final String password;
  final String fullName;
  final String birth;
  final String foreignNumber;
  final String nationality;
  final String primaryIndustry;
  final String secondaryIndustry;
  final String imagePath;

  RegisterUser({
    required this.email,
    required this.password,
    required this.fullName,
    required this.birth,
    required this.foreignNumber,
    required this.nationality,
    required this.primaryIndustry,
    required this.secondaryIndustry,
    required this.imagePath,
  });

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

final userRegisterProvider = StateProvider<RegisterUser?>((ref) => null);
