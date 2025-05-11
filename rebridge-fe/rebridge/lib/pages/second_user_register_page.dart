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
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController foreignnumberController = TextEditingController();

  bool isAllFilled = false;

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(_checkFields);
    birthController.addListener(_checkFields);
    foreignnumberController.addListener(_checkFields);
  }

  void _checkFields() {
    final allFilled = fullNameController.text.isNotEmpty &&
        birthController.text.isNotEmpty &&
        foreignnumberController.text.isNotEmpty;

    setState(() {
      isAllFilled = allFilled;
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    birthController.dispose();
    foreignnumberController.dispose();
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
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Full Name'),
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ButtonStyles.borderradius(context)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Date of Birth'),
                    TextField(
                      controller: birthController,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ButtonStyles.borderradius(context)),
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
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Foreigner\'s registration number'),
                    TextField(
                      controller: foreignnumberController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ButtonStyles.borderradius(context)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.08),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isAllFilled
                            ? () {
                                final current = ref.read(userRegisterProvider);
                                if (current == null) return;

                                ref.read(userRegisterProvider.notifier).state =
                                    current.copyWith(
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

                                context.push('/finalRegister');
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAllFilled
                              ? ButtonStyles.buttonColor
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ButtonStyles.borderradius(context)),
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
