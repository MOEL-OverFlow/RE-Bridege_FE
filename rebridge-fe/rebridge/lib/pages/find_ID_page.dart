import 'package:flutter/material.dart';
import 'package:rebridge/data/api/Find_api.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/device_styles.dart';

import '../shared/styles/button_style.dart';

class FindIdPage extends StatefulWidget {
  const FindIdPage({super.key});
  @override
  State<FindIdPage> createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController registrationnumberController =
      TextEditingController();

  String? selectedCountry;

  final List<String> countries = [
    'South Korea',
    'United States',
    'Japan',
    'Germany',
    'Australia'
  ];

  Future<void> _findId() async {
    final name = nameController.text.trim();
    final birth = birthController.text.trim();
    final registrationNumber = registrationnumberController.text.trim();
    final country = selectedCountry;

    await FindApi.FindId(name, birth, registrationNumber, country, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.08,
            vertical: DeviceStyles.screenHeight(context) * 0.03,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Find ID',
                        style: TextStyle(
                          fontSize: DeviceStyles.screenWidth(context) * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.04),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceStyles.screenWidth(context) * 0.04,
                  vertical: DeviceStyles.screenHeight(context) * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ButtonStyles.borderradius(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Foreigner' ' registration number'),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    TextField(
                      controller: registrationnumberController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              ButtonStyles.borderradius(context))),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Name'),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              ButtonStyles.borderradius(context))),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Country'),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    DropdownButtonFormField<String>(
                      value: selectedCountry,
                      items: countries
                          .map((country) => DropdownMenuItem(
                                value: country,
                                child: Text(country),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              ButtonStyles.borderradius(context))),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    const Text('Date of Birth'),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    TextField(
                      controller: birthController,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                        filled: true,
                        fillColor: const Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              ButtonStyles.borderradius(context))),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            birthController.text =
                                '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.05),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _findId,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ButtonStyles.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ButtonStyles.borderradius(context)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ButtonStyles.paddingwidth(context),
                              vertical: ButtonStyles.paddingheight(context)),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontSize:
                                    DeviceStyles.screenWidth(context) * 0.04,
                                color: Colors.white),
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
