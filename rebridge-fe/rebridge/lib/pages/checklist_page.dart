import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import '../../shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool severancePay = false;

  // Training Program toggles
  bool resettlementSupport = false;
  bool foreignWorkerTraining = false;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
                  : "테스트",
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
                    } else if (title == 'Severance Pay') {
                      _launchUrl('https://hrdc.hrdkorea.or.kr/hrdc/104013');
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.08,
            vertical: DeviceStyles.screenHeight(context) * 0.03,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go('/membershipguide');
                    },
                  ),
                ],
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Check List',
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Insurance Section
                      _buildSectionTitle('Insurances'),
                      _buildCheckboxItem(
                          'Departure Insurance', departureInsurance, (value) {
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
                      _buildCheckboxItem(
                          'Accident Insurance', accidentInsurance, (value) {
                        setState(() {
                          accidentInsurance = value ?? false;
                        });
                      }, () => _showItemDialog('Accident Insurance')),
                      const Divider(),

                      // Documents Section
                      _buildSectionTitle('Documents'),
                      _buildCheckboxItem(
                          'Custom Declaration', customDeclaration, (value) {
                        setState(() {
                          customDeclaration = value ?? false;
                        });
                      }, () => _showItemDialog('Custom Declaration')),
                      _buildCheckboxItem('Severance Pay', severancePay,
                          (value) {
                        setState(() {
                          severancePay = value ?? false;
                        });
                      }, () => _showItemDialog('Severance Pay')),
                      const Divider(),

                      // Training Programs Section
                      _buildSectionTitle('Training Programs'),
                      _buildCheckboxItem(
                          'Resettlement Support', resettlementSupport, (value) {
                        setState(() {
                          resettlementSupport = value ?? false;
                        });
                      }, () => _showItemDialog('Resettlement Support')),
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D65E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ButtonStyles.borderradius(context)),
                    ),
                  ),
                  onPressed: () {
                    // Add your submit logic here
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
            ],
          ),
        ),
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
