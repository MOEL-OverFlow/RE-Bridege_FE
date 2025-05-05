import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebridge/data/api/register_api.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/dialog_cancel_util.dart';
import 'dart:io';

import 'package:rebridge/shared/utils/dialog_util.dart';

class FinalUserRegisterPage extends ConsumerStatefulWidget {
  const FinalUserRegisterPage({super.key});

  @override
  ConsumerState<FinalUserRegisterPage> createState() =>
      _FinalUserRegisterPageState();
}

class _FinalUserRegisterPageState extends ConsumerState<FinalUserRegisterPage> {
  String? selectedNationality;
  String? selectedPrimaryIndustry;
  String? selectedSecondaryIndustry;

  File? selectedImage;

  final List<String> nationalityOptions = [
    'Korea',
    'Vietnam',
    'Philippines',
    'Indonesia',
    'China',
    'Thailand',
    'USA',
    'Other'
  ];

  final List<String> industryOptions = [
    'Manufacturing',
    'Construction',
    'IT & Software',
    'Healthcare',
    'Education',
    'Agriculture',
    'Retail',
    'Finance',
    'Other'
  ];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
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
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 바
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async {
                      final shouldGoBack =
                          await DialogCancelUtil.showCancelCustomDialog(
                        context,
                        title: 'Warn',
                        content:
                            'You will need to re-enter your email. Would you like to go back to the previous one though?',
                      );

                      if (shouldGoBack) {
                        context.go('/firstRegister');
                      }
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // 컨텐츠 박스
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ButtonStyles.borderradius(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 국적
                    const Text('Nationality'),
                    DropdownButtonFormField<String>(
                      value: selectedNationality,
                      items: nationalityOptions
                          .map((nation) => DropdownMenuItem(
                                value: nation,
                                child: Text(nation),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedNationality = value;
                        });
                      },
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

                    // 1순위 산업
                    const Text('Primary Industry of Interest'),
                    DropdownButtonFormField<String>(
                      value: selectedPrimaryIndustry,
                      items: industryOptions
                          .map((industry) => DropdownMenuItem(
                                value: industry,
                                child: Text(industry),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPrimaryIndustry = value;
                        });
                      },
                      decoration: InputDecoration(
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

                    // 2순위 산업
                    const Text('Secondary Industry of Interest'),
                    DropdownButtonFormField<String>(
                      value: selectedSecondaryIndustry,
                      items: industryOptions
                          .map((industry) => DropdownMenuItem(
                                value: industry,
                                child: Text(industry),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSecondaryIndustry = value;
                        });
                      },
                      decoration: InputDecoration(
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

                    // 이미지
                    const Text('Profile Image'),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7EBFF),
                          borderRadius: BorderRadius.circular(
                              ButtonStyles.borderradius(context)),
                        ),
                        child: selectedImage == null
                            ? const Center(
                                child: Text('Tap to select an image'),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.04),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (selectedNationality != null &&
                                selectedPrimaryIndustry != null &&
                                selectedSecondaryIndustry != null)
                            ? () async {
                                final userData = ref.read(userRegisterProvider);

                                if (userData == null) {
                                  DialogUtil.showCustomDialog(
                                    context,
                                    title: 'Error',
                                    content: 'No registration data found.',
                                  );
                                  return;
                                }

                                ref.read(userRegisterProvider.notifier).state =
                                    RegisterUser(
                                  email: userData.email,
                                  password: userData.password,
                                  fullName: userData.fullName,
                                  birth: userData.birth,
                                  foreignNumber: userData.foreignNumber,
                                  nationality: selectedNationality,
                                  primaryIndustry: selectedPrimaryIndustry,
                                  secondaryIndustry: selectedSecondaryIndustry,
                                  imagePath: selectedImage?.path,
                                );

                                final shouldProceed = await DialogCancelUtil
                                    .showCancelCustomDialog(
                                  context,
                                  title: 'Confirm',
                                  content:
                                      'Do you want to proceed with registration?',
                                );

                                if (shouldProceed) {
                                  await RegisterApi.signup(context, ref);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (selectedNationality != null &&
                                  selectedPrimaryIndustry != null &&
                                  selectedSecondaryIndustry != null)
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
                            'Sign Up',
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
