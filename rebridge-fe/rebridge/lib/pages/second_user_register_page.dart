import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';

class SecondUserRegisterPage extends ConsumerStatefulWidget {
  const SecondUserRegisterPage({super.key});

  @override
  ConsumerState<SecondUserRegisterPage> createState() =>
      _SecondUserRegisterPageState();
}

class _SecondUserRegisterPageState
    extends ConsumerState<SecondUserRegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController foreignnumberController = TextEditingController();
  late TextEditingController emailController;

  bool isAllFilled = false;
  late String email;

  bool get isPasswordMatch =>
      passwordController.text.isNotEmpty &&
      passwordCheckController.text.isNotEmpty &&
      passwordController.text == passwordCheckController.text;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      _checkFields();
    });
    passwordCheckController.addListener(() {
      _checkFields();
    });
    fullNameController.addListener(_checkFields);
    birthController.addListener(_checkFields);
    foreignnumberController.addListener(_checkFields);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final extra = GoRouterState.of(context).extra;
    if (extra != null && extra is String) {
      email = extra;
    } else {
      email = 'No email provided';
    }

    emailController = TextEditingController(text: email);
  }

  void _checkFields() {
    final allFilled = passwordController.text.isNotEmpty &&
        passwordCheckController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        birthController.text.isNotEmpty &&
        foreignnumberController.text.isNotEmpty &&
        isPasswordMatch;

    if (allFilled != isAllFilled) {
      setState(() {
        isAllFilled = allFilled;
      });
    } else {
      setState(() {
        isAllFilled = false;
      });
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordCheckController.dispose();
    fullNameController.dispose();
    birthController.dispose();
    foreignnumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.05,
            vertical: DeviceStyles.screenHeight(context) * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go('/firstRegister');
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: DeviceStyles.screenWidth(context) * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: DeviceStyles.screenWidth(context) * 0.1),
                ],
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Container(
                padding:
                    EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ButtonStyles.borderradius(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Password'),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Must be at least 8 characters long',
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.02,
                    ),
                    const Text('Password Check'),
                    TextField(
                      controller: passwordCheckController,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Check password',
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: (() {
                          // 둘 다 비었으면 아이콘 없음
                          if (passwordController.text.isEmpty &&
                              passwordCheckController.text.isEmpty) {
                            return null;
                          }
                          // 일치하면 초록 체크, 아니면 빨간 X
                          return (isPasswordMatch)
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.close, color: Colors.red);
                        })(),
                      ),
                    ),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.02,
                    ),
                    const Text('Full Name'),
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.02,
                    ),
                    const Text('Date of Birth'),
                    TextField(
                      controller: birthController,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          birthController.text =
                              '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                          _checkFields();
                        }
                      },
                    ),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.02,
                    ),
                    const Text('Foreigner\'s registration number'),
                    TextField(
                      controller: foreignnumberController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.08,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isAllFilled
                            ? () {
                                // Provider에 데이터 저장
                                ref.read(userRegisterProvider.notifier).state =
                                    RegisterUser(
                                  email: email,
                                  password: passwordController.text,
                                  fullName: fullNameController.text,
                                  birth: birthController.text,
                                  foreignNumber: foreignnumberController.text,
                                );

                                print('✅ Provider에 회원가입 정보 저장 완료!');
                                final userData = ref.read(userRegisterProvider);
                                print('------ 현재 Provider 데이터 ------');
                                print('Email: ${userData?.email}');
                                print('Password: ${userData?.password}');
                                print('Full Name: ${userData?.fullName}');
                                print('Birth: ${userData?.birth}');
                                print(
                                    'Foreigner Number: ${userData?.foreignNumber}');
                                print('--------------------------------');
                                context.go('/finalRegister');
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAllFilled
                              ? ButtonStyles.buttonColor
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              ButtonStyles.borderradius(context),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ButtonStyles.paddingwidth(context),
                            vertical: ButtonStyles.paddingheight(context),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.04,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
