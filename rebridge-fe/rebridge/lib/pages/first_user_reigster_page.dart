import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/data/api/register_api.dart';

class FirstUserRegisterPage extends ConsumerStatefulWidget {
  const FirstUserRegisterPage({super.key});

  @override
  ConsumerState<FirstUserRegisterPage> createState() =>
      _FirstUserRegisterPageState();
}

class _FirstUserRegisterPageState extends ConsumerState<FirstUserRegisterPage> {
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController emailDomainController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isManualEmailInput = false;

  bool isAllFilled = false;
  String? selectedDomain;
  bool isDomainEditable = true;

  bool isCodeSent = false;
  bool isConfirm = false;
  bool get isPasswordMatch =>
      passwordController.text.isNotEmpty &&
      passwordCheckController.text.isNotEmpty &&
      passwordController.text == passwordCheckController.text;
  final List<String> emailDomains = [
    'gmail.com',
    'naver.com',
    'daum.net',
    'hanmail.net',
    'yahoo.com',
    'hotmail.com',
    'Enter Manually'
  ];

  @override
  void initState() {
    super.initState();
    emailIdController.addListener(_checkFields);
    emailDomainController.addListener(_checkFields);
    verificationCodeController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
    passwordCheckController.addListener(_checkFields);
    fullNameController.addListener(_checkFields);
    birthController.addListener(_checkFields);
  }

  void _checkFields() {
    final allFilled = emailIdController.text.isNotEmpty &&
        emailDomainController.text.isNotEmpty &&
        verificationCodeController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordCheckController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        birthController.text.isNotEmpty;

    if (allFilled != isAllFilled) {
      setState(() {
        isAllFilled = allFilled;
      });
    }
  }

  @override
  void dispose() {
    emailIdController.dispose();
    emailDomainController.dispose();
    verificationCodeController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    fullNameController.dispose();
    birthController.dispose();
    super.dispose();
  }

  void _handleDomainChange(String? value) {
    setState(() {
      selectedDomain = value;
      if (value == 'Enter Manually') {
        isManualEmailInput = true;
        emailDomainController.clear();
      } else {
        isManualEmailInput = false;
        emailDomainController.text = value ?? '';
      }
    });
  }

  Future<void> _sendCode() async {
    final emailId = emailIdController.text;
    final emailDomain = emailDomainController.text;
    final result = await RegisterApi.sendCode(context, emailId, emailDomain);
    if (result) {
      setState(() {
        isCodeSent = true;
      });
    }
  }

  Future<void> _codeConfirm() async {
    final certificationCode = verificationCodeController.text;
    final result = await RegisterApi.verifyCode(context, certificationCode);

    if (result) {
      setState(() {
        isConfirm = true;
      });
    }
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.06),
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
                    const Text('Email'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: emailIdController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color(0xFFE7EBFF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ButtonStyles.borderradius(
                                                context))),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      DeviceStyles.screenWidth(context) * 0.01),
                              child: const Text('@'),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: emailDomainController,
                                enabled: isManualEmailInput,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color(0xFFE7EBFF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ButtonStyles.borderradius(
                                                context))),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    DeviceStyles.screenWidth(context) * 0.01),
                            Container(
                              width: DeviceStyles.screenWidth(context) * 0.1,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7EBFF),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    ButtonStyles.borderradius(context))),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: null,
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  items: emailDomains.map((String domain) {
                                    return DropdownMenuItem<String>(
                                      value: domain,
                                      child: Text(domain),
                                    );
                                  }).toList(),
                                  onChanged: _handleDomainChange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _sendCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9DB6FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ButtonStyles.borderradius(context)),
                          ),
                        ),
                        child: const Text(
                          'send code',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    if (isCodeSent) ...[
                      const Text('Verification Code'),
                      TextField(
                        controller: verificationCodeController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: const Color(0xFFE7EBFF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                ButtonStyles.borderradius(context))),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: DeviceStyles.screenHeight(context) * 0.01),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _codeConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9DB6FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ButtonStyles.borderradius(context)),
                            ),
                          ),
                          child: const Text(
                            'Code Confirm',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: DeviceStyles.screenHeight(context) * 0.02),
                      if (isConfirm) ...[
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
                              if (passwordController.text.isEmpty &&
                                  passwordCheckController.text.isEmpty) {
                                return null;
                              }

                              return (isPasswordMatch)
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.green)
                                  : const Icon(Icons.close, color: Colors.red);
                            })(),
                          ),
                        ),
                        SizedBox(
                            height: DeviceStyles.screenHeight(context) * 0.08),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final email =
                                  '${emailIdController.text}@${emailDomainController.text}';
                              final password = passwordController.text;

                              final prevState = ref.read(userRegisterProvider);

                              ref.read(userRegisterProvider.notifier).state =
                                  RegisterUser(
                                email: email,
                                password: password,
                                fullName: prevState?.fullName ?? '',
                                birth: prevState?.birth ?? '',
                                foreignNumber: prevState?.foreignNumber ?? '',
                                nationality: prevState?.nationality ?? '',
                                primaryIndustry:
                                    prevState?.primaryIndustry ?? '',
                                secondaryIndustry:
                                    prevState?.secondaryIndustry ?? '',
                                imagePath: prevState?.imagePath ?? '',
                              );

                              context.push('/secondRegister');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ButtonStyles.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ButtonStyles.borderradius(context)),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ButtonStyles.paddingwidth(context),
                                  vertical:
                                      ButtonStyles.paddingheight(context)),
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    fontSize:
                                        DeviceStyles.screenWidth(context) *
                                            0.04,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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
