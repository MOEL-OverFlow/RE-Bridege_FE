import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import '../../shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';
import 'package:url_launcher/url_launcher.dart';
// 서버 연결 필요
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // Insurance toggles
  bool departureInsurance = false;
  bool expenseInsurance = false;
  bool suretyInsurance = false;
  bool accidentInsurance = false;

  // Documents toggles
  bool customDeclaration = false;
  bool retirementAllowance = false;

  // Education Program toggles
  bool repatriationSupport = false;
  bool foreignWorkerTraining = false;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // Future<void> _submitChecklist() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://localhost:8080/checklists'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'customDeclaration': customDeclaration,
  //         'retirementAllowance': retirementAllowance,
  //         'departureInsurance': departureInsurance,
  //         'expenseInsurance': expenseInsurance,
  //         'suretyInsurance': suretyInsurance,
  //         'accidentInsurance': accidentInsurance,
  //         'repatriationSupport': repatriationSupport,
  //         'foreignWorkerTraining': foreignWorkerTraining,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // 성공 시 처리
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Checklist submitted successfully')),
  //       );
  //     } else {
  //       // 실패 시 처리
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to submit checklist')),
  //       );
  //     }
  //   } catch (e) {
  //     // 에러 처리
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${e.toString()}')),
  //     );
  //   }
  // }

  void _showItemDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFe9eeff),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          width: 300,
          height: 200,
          child: SingleChildScrollView(
            child: Text(
              title == 'Departure Insurance' ||
                      title == 'Expense Insurance' ||
                      title == 'Surety Insurance' ||
                      title == 'Accident Insurance'
                  ? '''🔎Insurance & Employment Information for Foreign Workers
1) Check Subscription and Claim Status of Departure Guarantee Insurance & Return Cost Insurance
Contact: +82-1600-0266 (Samsung Fire & Marine Insurance)

2) Check Subscription and Claim Status of Wage Payment Guarantee Insurance
Contact: +82-2-777-6689 (Seoul Guarantee Insurance)

Or visit: http://eps.sgic.co.kr
➡️Enter your Employment Permit Number to check.

🔎 When Does the Employment Contract Take Effect?
E-9 Visa
(First-time entry) Date of entry into Korea
(Re-entry special cases) The next day after being handed over (induction day)

H-2 Visa
Starting date of employment contract'''
                  : title == 'Repatriation Support' ||
                          title == 'Foreign Worker Training'
                      ? '''This is an educational program designed to help foreign workers acquire Korean language skills and necessary technical skills during their stay in Korea, ensuring stable repatriation to their home country upon the expiration of their stay.'''
                      : "Documents",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ButtonStyles.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (title == 'Departure Insurance') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Departure-Guarantee-Insurance-1f07c2138e7a806fb081f99fdf1c215f');
                    } else if (title == 'Expense Insurance') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Return-Cost-Insurance-1f07c2138e7a807490c1f5b172b703fe');
                    } else if (title == 'Surety Insurance') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Wage-Guarantee-Insurance-1f07c2138e7a802d9751c7b22564c1d4');
                    } else if (title == 'Accident Insurance') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Accident-Insurance-1f07c2138e7a80f9a853d8a0d65784ea');
                    } else if (title == 'Custom Declaration') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Custom-Declaration-1f07c2138e7a80279f5dc91b2f2ad58b');
                    } else if (title == 'Retirement Allowance') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Retirement-Allowance-Settlement-1f07c2138e7a80898604cfda799b9ac2');
                    } else if (title == 'Repatriation Support') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Repatriation-Support-1f07c2138e7a806c88e0d92afc2cf938');
                    } else if (title == 'Foreign Worker Training') {
                      _launchUrl(
                          'https://impossible-repair-22e.notion.site/Training-for-Foreign-Workers-1f07c2138e7a80e2847eff0ea18c59f6');
                    }
                  },
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ButtonStyles.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (title == 'Departure Insurance' ||
                        title == 'Expense Insurance' ||
                        title == 'Surety Insurance' ||
                        title == 'Accident Insurance') {
                      _launchUrl(
                          'https://eps.hrdkorea.or.kr/e9/user/intro/intro.do?method=epsInsurances');
                    } else if (title == 'Custom Declaration') {
                      _launchUrl(
                          'https://www.customs.go.kr/incheon_airport/cm/cntnts/cntntsView.do?mi=12547&cntntsId=6688');
                    } else if (title == 'Retirement Allowance') {
                      _launchUrl('https://hrdc.hrdkorea.or.kr/hrdc/104013');
                    } else if (title == 'Repatriation Support' ||
                        title == 'Foreign Worker Training') {
                      _launchUrl(
                          'https://eps.hrdkorea.or.kr/e9/user/programs/programs.do?method=programsGuid');
                    }
                  },
                  child: const Text(
                    'Website',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: Column(
        children: [
          // Fixed Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DeviceStyles.screenWidth(context) * 0.05,
              vertical: DeviceStyles.screenHeight(context) * 0.02,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Check List',
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
          ),
          SizedBox(height: DeviceStyles.screenHeight(context) * 0.06),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: DeviceStyles.screenWidth(context) * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Insurance Section
                  _buildSectionTitle('Insurances'),
                  _buildCheckboxItem('Departure Insurance', departureInsurance,
                      (value) {
                    setState(() {
                      departureInsurance = value ?? false;
                    });
                  }, () => _showItemDialog('Departure Insurance')),
                  _buildCheckboxItem('Expense Insurance', expenseInsurance,
                      (value) {
                    setState(() {
                      expenseInsurance = value ?? false;
                    });
                  }, () => _showItemDialog('Expense Insurance')),
                  _buildCheckboxItem('Surety Insurance', suretyInsurance,
                      (value) {
                    setState(() {
                      suretyInsurance = value ?? false;
                    });
                  }, () => _showItemDialog('Surety Insurance')),
                  _buildCheckboxItem('Accident Insurance', accidentInsurance,
                      (value) {
                    setState(() {
                      accidentInsurance = value ?? false;
                    });
                  }, () => _showItemDialog('Accident Insurance')),
                  const Divider(),

                  // Documents Section
                  _buildSectionTitle('Documents'),
                  _buildCheckboxItem('Custom Declaration', customDeclaration,
                      (value) {
                    setState(() {
                      customDeclaration = value ?? false;
                    });
                  }, () => _showItemDialog('Custom Declaration')),
                  _buildCheckboxItem(
                      'Retirement Allowance', retirementAllowance, (value) {
                    setState(() {
                      retirementAllowance = value ?? false;
                    });
                  }, () => _showItemDialog('Retirement Allowance')),
                  const Divider(),

                  // Education Programs Section
                  _buildSectionTitle('Education Programs'),
                  _buildCheckboxItem(
                      'Repatriation Support', repatriationSupport, (value) {
                    setState(() {
                      repatriationSupport = value ?? false;
                    });
                  }, () => _showItemDialog('Repatriation Support')),
                  _buildCheckboxItem(
                      'Foreign Worker Training', foreignWorkerTraining,
                      (value) {
                    setState(() {
                      foreignWorkerTraining = value ?? false;
                    });
                  }, () => _showItemDialog('Foreign Worker Training')),
                ],
              ),
            ),
          ),
          // Fixed Submit Button
          Padding(
            padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.08),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ButtonStyles.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        ButtonStyles.borderradius(context)),
                  ),
                ),
                onPressed: () {
                  //_submitChecklist();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ButtonStyles.paddingwidth(context),
                      vertical: ButtonStyles.paddingheight(context)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: DeviceStyles.screenWidth(context) * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: DeviceStyles.screenWidth(context) * 0.04,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(
      String title, bool value, Function(bool?) onChanged, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: DeviceStyles.screenWidth(context) * 0.035,
                color: Colors.grey,
              ),
            ),
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
