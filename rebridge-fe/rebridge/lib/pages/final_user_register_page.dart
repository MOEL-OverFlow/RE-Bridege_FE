import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    'BANGLADESH',
    'CAMBODIA',
    'CHINA',
    'INDONESIA',
    'KYRGYZ',
    'LAOS',
    'MONGOLIA',
    'MYANMAR',
    'NEPAL',
    'PAKISTAN',
    'PHILIPPINES',
    'SRI_LANKA',
    'THAILAND',
    'TIMOR_LESTE',
    'UZBEKISTAN',
    'VIETNAM',
    'SOUTH_KOREA',
    'OTHER'
  ];

  final List<String> industryOptions = [
    'CONSTRUCTION',
    'METAL',
    'MACHINE',
    'ELECTRICITY',
    'ELECTRONIC',
    'TELECOMMUNICATIONS',
    'TEXTILE',
    'CHEMICALS',
    'FOOD',
    'AGRICULTURE',
    'STOCKBREEDING',
    'FISHERY',
    'WOODWORK',
    'TRANSPORT',
    'NONE'
  ];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });

      final current = ref.read(userRegisterProvider);
      if (current != null) {
        ref.read(userRegisterProvider.notifier).state = current.copyWith(
          imagePath: pickedFile.path,
        );
      }
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
              Row(
                children: [
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

                        final current = ref.read(userRegisterProvider);
                        if (current != null) {
                          ref.read(userRegisterProvider.notifier).state =
                              current.copyWith(nationality: value);
                        }
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

                        final current = ref.read(userRegisterProvider);
                        if (current != null) {
                          ref.read(userRegisterProvider.notifier).state =
                              current.copyWith(primaryIndustry: value);
                        }
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

                        final current = ref.read(userRegisterProvider);
                        if (current != null) {
                          ref.read(userRegisterProvider.notifier).state =
                              current.copyWith(secondaryIndustry: value);
                        }
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
