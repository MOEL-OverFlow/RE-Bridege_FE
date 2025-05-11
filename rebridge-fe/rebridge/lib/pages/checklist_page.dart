import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import '../../shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';
import '../../shared/utils/dialog_util.dart';

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

  void _showItemDialog(String title) {
    String content = "테스트";
    if (title == 'Departure Insurance') {
      content =
          '''Purpose: To ease employers' burden of paying severance at once and to prevent illegal stays.

Legal Basis: Article 13 of the Act on Foreign Workers; Article 21 of the Enforcement Decree.

Who Must Enroll: Employers.

Applicable Workplaces: Workplaces employing foreign workers whose remaining period of employment is at least 1 year.

Beneficiaries: Foreign workers.

Enrollment Period & Penalty: Must enroll within 15 days from the start date of the employment contract; fine up to 5 million KRW if not enrolled.

Payment Method: 8.3% of the worker's monthly ordinary wages, deposited monthly.

Benefit Conditions: Paid when a foreign worker who has worked at least 1 year leaves Korea (except temporary departures) or changes status of stay.

Payout Amount: 100.5% to 102.3% of the worker's wages if they have worked at least 1 year and 12 months have passed since the first payment.''';
    }
    DialogUtil.showCustomDialog(
      context,
      title: title,
      content: content,
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
