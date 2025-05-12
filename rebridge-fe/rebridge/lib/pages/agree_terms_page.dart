import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';
import '../../shared/styles/logo_styles.dart';
import '../../shared/styles/background_styles.dart';

class AgreeTermsPage extends StatefulWidget {
  const AgreeTermsPage({super.key});

  @override
  State<AgreeTermsPage> createState() => _AgreeTermsPageState();
}

class _AgreeTermsPageState extends State<AgreeTermsPage> {
  bool acceptAll = false;
  bool acceptTerms = false;
  bool acceptPersonalInfo = false;
  bool accpetguidelines = false;
  bool acceptItems = false;

  static const String _termsContent = '''
Chapter 1 General Provisions

Article 1 (Objective)
The objective of this Agreement is to define the terms and conditions, procedures, and other necessary items regarding the use of the recruitment information service (hereinafter referred to as “Service”) of HRD Korea (the Human Resources Development Service of Korea) and relevant institutions (http://eps.hrdkorea.or.kr/e9) offered by HRD Korea on the internet.

Article 2 (Definitions)
The definitions of terminologies used in this agreement are as follows.
1. A "member" means an individual who signed a service use contract for HRD Korea’s Return Job to utilize web information.
2. A "user" means any person who utilizes Return Job of HRD Korea regardless of whether or not the person signed a service use contract...
3. "ID" means a combination of English letters and numbers given by the Return Job of HRD Korea...
(중략)
Article 19 (Settlement of Conflicts)
1. HRD Korea and members shall exert all necessary efforts to smoothly solve any conflicts arising from the service.
2. Notwithstanding the above paragraph, any lawsuit for any conflict shall be governed by a competent court in the jurisdiction of HRD Korea.

Bylaws
1. (Date of enforcement) This Agreement shall be enforced from December 1st, 2009.
''';

  static const String _termsContent2 = '''
The following optional information is being collected and used to ensure user convenience in the provided “Return Job Website” service. However, the scope of information may be expanded to provide additional services as long as the purpose of use does not stray from the purpose of collection, and in such cases, members shall be notified in advance.


1. Purpose of the Collection and Use of Personal Information
○ The "Return Job Website" shall collect personal information for the following purposes.

- Member sign up and management of the website

- Contacts and notifications regarding the jobs to support foreign workers returning to their home countries

- Offering of services related to supporting foreign workers returning to their home countries

- Support of job seeking activities of foreign workers returning to their home countries in Korean companies in their home countries

- Satisfaction survery

○ The collected personal information shall not be used for any purpose other than the above purpose. In the event that the purpose of use is changed, necessary actions such as receiving additional agreement shall be taken in accordance with Article 18 of the Personal Information Protection Act.


2. Items of Personal Information to be Collected (Required Information)
○ Name, e-mail address, foreigner’s registration number, passport number, gender, age, nationality, home country phone number, SMS reception(yes/no), e-mail reception(yes/no)r


3. Period of Keeping and Use of Personal Information
○ Period of Keeping and Use: 3 year from the expiration date of length of stay


4. Right to Refuse the Collection of Personal Information and Subsequent Limitations on Service
○ Although a user may reserve the right to refuse an agreement for collection of personal information on the “Return Job Website”, they may encounter limitations on signing up for membership and service use when refusing to agree to the collection and use of the required items.


5. Collection of Personal Information and Users: HRD Korea
''';

  static const String _termsContent3 = '''
The following optional information is being collected and used to ensure user convenience in the provided “Return Job Website” service. However, the scope of information may be expanded to provide additional services as long as the purpose of use does not stray from the purpose of collection, and in such cases, members shall be notified in advance.


1. Purpose of Collection and Use of Personal Information
○ The "Return Job Website" shall collect personal information for the following purposes.

- Member sign up and management of the website

- Contacts and notifications regarding the jobs to support foreign workers returning to their home countries

- Offering of services related to supporting foreign workers returning to their home countries

- Support of job seeking activities of foreign workers returning to their home countries in Korean companies in their home countries

- Satisfaction survery

○ The collected personal information shall not be used for any purpose other than the above purpose. In the event that the purpose of use is changed, necessary actions such as receiving additional agreement shall be taken in accordance with Article 18 of the Personal Information Protection Act.


2. Items of Personal Information to be Collected (Optional Information)
○Date of birth, nationality,address in home country, work experience in Korea, usable languages, desired occupation


3. Period of Keeping and Use of Personal Information
○ Period of Keeping and Use: 3 year from the expiration date of length of stay


4. Relevant Statutory Laws
○ Paragraph 1 (Support for entry and departure of foreign workers), Article 21 of the Act on the Employment, etc. of Foreign Workers

○ Article 53 of the Rules on Employment Support Handling for Foreign Workers (Departure Support for Foreign Workers)


5. Right to Refuse the Collection of Personal Information and Subsequent Limitations on Service
○ Although a user may reserve the right to refuse an agreement for collection of personal information on the “Return Job Website”, they may encounter limitations on signing up for membership and service use when refusing to agree to the collection and use of the required items.


6. Collection of Personal Information and Users: HRD Korea
''';

  static const String _termsContent4 = '''
To support foreign workers who plan to return to their home countries find employment in their home countries, “Return Job Website” offers information from the job application forms of foreign workers to Korean companies that support the return of foreign workers to their home countries with the prior consent of such foreign workers. The period of offering such information is 3 years from the registration date of the job application form.


1. Purpose of Collection and Use of Personal Information
○ The "Return Job Website" shall collect personal information for the following purposes.

- Member sign up and management of the website

- Contacts and notifications regarding the jobs to support foreign workers returning to their home countries

- Offering of services related to supporting foreign workers returning to their home countries

- Support of job seeking activities of foreign workers returning to their home countries in Korean companies in their home countries

- Satisfaction survery

○ The collected personal information shall not be used for any purpose other than the above purpose. In the event that the purpose of use is changed, necessary actions such as receiving additional agreement shall be taken in accordance with Article 18 of the Personal Information Protection Act.


2. Recipient of Information: Korean companies in the home countries of foreign workers
3. Items of Personal Information to be Collected: Return Job Foreign Worker Job Search Application Form Information
○ Job Search Application Form: Date of birth, address in home country, work experience in Korea, usable languages, final academic background and majors, qualifications, desired occupation


4. Period of Keeping and Use of Personal Information
○ Period of Keeping and Use: 3 year from the expiration date of length of stay


5. Right to Refuse the Collection of Personal Information and Subsequent Limitations on Service
○ Although a user may reserve the right to refuse an agreement for the offering of collected personal information to a third party, they may have limitations of service use offered by the “Return Job Website.” There are no limitations on signing up for membership when refusing to agree on the offering of personal information to a third party.



The “Return Job Website” shall not disclose personal information to a third party without the additional agreement of the user concerned, but HRD Korea may furnish the personal information of a registered user to a third party without their additional agreement for each of the following cases.


1. Offering a user’s personal information, such as name or address, to a national investigative agency in cooperation with an investigation upon written request by the investigative agency in accordance with the purpose of the investigation
2. In the event that there is a special regulation in the laws such as the Credit Information Use and Protection Act and laws on telecommunication
3. Offering a user’s personal information in a form in which a specific individual is not recognizable when necessary for cases such as the preparation of statistics, scientific research, or market research
○ A user of “Return Job Website” may cancel additional agreement on the collection and use of personal information, additional agreement on the use of personal information other than the original purpose of use, and additional agreement on the offering of personal information to a third party by terminating the service use contract at any time. If a user desires to terminate the service use contract, then they may do so through the termination procedures of EPS of HRD Korea.
''';

  void _toggleAcceptAll(bool? value) {
    setState(() {
      acceptAll = value ?? false;
      acceptTerms = acceptAll;
      acceptPersonalInfo = acceptAll;
      accpetguidelines = acceptAll;
      acceptItems = acceptAll;
    });
  }

  void _toggleIndividual(String type, bool? value) {
    setState(() {
      if (type == 'terms') {
        acceptTerms = value ?? false;
      } else if (type == 'personal') {
        acceptPersonalInfo = value ?? false;
      } else if (type == 'guidelines') {
        accpetguidelines = value ?? false;
      } else if (type == 'items') {
        acceptItems = value ?? false;
      }

      acceptAll = acceptTerms && acceptPersonalInfo && accpetguidelines;
    });
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Image.asset(
                'assets/images/register_logo_imgage.png',
                width: LogoStyles.width(context),
                height: LogoStyles.height(context),
                fit: LogoStyles.fit,
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Agree to the Terms and Conditions',
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Accept All',
                    style: TextStyle(
                      fontSize: DeviceStyles.screenWidth(context) * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(
                    value: acceptAll,
                    onChanged: _toggleAcceptAll,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Text(
                          'User Agreement',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DialogUtil.showCustomDialog(
                        context,
                        title: 'User Agreement',
                        content: _termsContent,
                      );
                    },
                    child: const Icon(Icons.chevron_right),
                  ),
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) => _toggleIndividual('terms', value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            'Guidelines on the collection and use of identification information',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DialogUtil.showCustomDialog(
                        context,
                        title:
                            'Guidelines on the collection and use of identification information',
                        content: _termsContent2,
                      );
                    },
                    child: const Icon(Icons.chevron_right),
                  ),
                  Checkbox(
                    value: acceptPersonalInfo,
                    onChanged: (value) => _toggleIndividual('personal', value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            'Guidelines on the Collection and Use of Personal Information (Optional Information)',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DialogUtil.showCustomDialog(
                        context,
                        title:
                            'Guidelines on the Collection and Use of Personal Information (Optional Information)',
                        content: _termsContent3,
                      );
                    },
                    child: const Icon(Icons.chevron_right),
                  ),
                  Checkbox(
                    value: accpetguidelines,
                    onChanged: (value) =>
                        _toggleIndividual('guidelines', value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Required ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: DeviceStyles.screenWidth(context) * 0.035,
                          ),
                        ),
                        SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            'Items Regarding the Offering of Personal Information to a Third Party',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  DeviceStyles.screenWidth(context) * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DialogUtil.showCustomDialog(
                        context,
                        title:
                            'Items Regarding the Offering of Personal Information to a Third Party',
                        content: _termsContent4,
                      );
                    },
                    child: const Icon(Icons.chevron_right),
                  ),
                  Checkbox(
                    value: acceptItems,
                    onChanged: (value) => _toggleIndividual('items', value),
                  ),
                ],
              ),
              const Spacer(),
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
                  onPressed: (acceptTerms && acceptPersonalInfo)
                      ? () {
                          context.push('/firstRegister');
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ButtonStyles.paddingwidth(context),
                        vertical: ButtonStyles.paddingheight(context)),
                    child: Text(
                      'I agree',
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
}
