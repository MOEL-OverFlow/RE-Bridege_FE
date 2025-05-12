import 'package:flutter/material.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/company_card.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  final List<Map<String, String>> companyList = [
    {
      'name': 'ABC Construction',
      'field': 'CONSTRUCTION',
      'country': 'Korea',
      'recruit': '10',
      'career': '1+ years',
      'language': 'Basic',
      'deadline': '2025-06-30',
      'url': '',
      'jobType': 'PRODUCTION_MANAGEMENT',
      'industryType': 'CONSTRUCTION',
      'experience': 'ENTRY',
      'koreanSkill': 'MEDIUM',
    },
    {
      'name': 'XYZ Electronics',
      'field': 'ELECTRONIC',
      'country': 'Vietnam',
      'recruit': '5',
      'career': 'Any',
      'language': 'Intermediate',
      'deadline': '2025-07-15',
      'url': '',
      'jobType': 'INTERPRET',
      'industryType': 'MANUFACTURING',
      'experience': 'NONE',
      'koreanSkill': 'LOW',
    },
    {
      'name': 'Green Foods',
      'field': 'FOOD',
      'country': 'Uzbekistan',
      'recruit': '3',
      'career': '2+ years',
      'language': 'Advanced',
      'deadline': '2025-06-01',
      'url': '',
      'jobType': 'CLERICAL_WORK',
      'industryType': 'AGRICULTURE_FORESTRY_FISHERY',
      'experience': 'EXPERIENCED',
      'koreanSkill': 'HIGH',
    },
    {
      'name': 'Sky Telecom',
      'field': 'TELECOMMUNICATIONS',
      'country': 'Nepal',
      'recruit': '4',
      'career': 'Any',
      'language': 'Basic',
      'deadline': '2025-06-20',
      'url': '',
      'jobType': 'BUSINESS_MANAGEMENT',
      'industryType': 'MEDIA_COMMUNICATION',
      'experience': 'NONE',
      'koreanSkill': 'MEDIUM',
    },
    {
      'name': 'Ocean Fishery',
      'field': 'FISHERY',
      'country': 'Thailand',
      'recruit': '8',
      'career': '3+ years',
      'language': 'Intermediate',
      'deadline': '2025-08-10',
      'url': '',
      'jobType': 'PRODUCTION_MANAGEMENT',
      'industryType': 'FISHERY',
      'experience': 'EXPERIENCED',
      'koreanSkill': 'LOW',
    },
  ]; // 생략 (기존 리스트 유지)

  String? selectedCountry;
  String? selectedField;
  String? selectedJobType;
  String? selectedIndustryType;
  String? selectedExperience;
  String? selectedKoreanSkill;

  final List<String> countryOptions = [
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

  final List<String> fieldOptions = [
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
    'TRANSPORT'
  ];

  final List<String> jobTypeOptions = [
    'PRODUCTION_MANAGEMENT',
    'BUSINESS_MANAGEMENT',
    'INTERPRET',
    'CLERICAL_WORK'
  ];

  final List<String> industryTypeOptions = [
    'AGRICULTURE_FORESTRY_FISHERY',
    'MINING',
    'MANUFACTURING',
    'ELECTRICITY_GAS_WATER',
    'WASTE_ENVIRONMENT',
    'CONSTRUCTION',
    'WHOLESALE_RETAIL',
    'TRANSPORTATION',
    'ACCOMMODATION_FOOD',
    'MEDIA_COMMUNICATION',
    'FINANCE_INSURANCE',
    'REAL_ESTATE',
    'SCIENCE_TECH',
    'BUSINESS_SUPPORT',
    'PUBLIC_ADMINISTRATION',
    'EDUCATION',
    'HEALTH_SOCIAL_WORK',
    'ARTS_SPORTS',
    'ASSOCIATIONS_PERSONAL_SERVICES',
    'HOUSEHOLD_SELF_PRODUCTION',
    'INTERNATIONAL_ORGANIZATIONS'
  ];

  final List<String> experienceOptions = ['ENTRY', 'EXPERIENCED'];
  final List<String> koreanSkillOptions = ['HIGH', 'MEDIUM', 'LOW'];

  bool showFilters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.08,
            vertical: DeviceStyles.screenHeight(context) * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company List',
                style: TextStyle(
                  fontSize: DeviceStyles.screenWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() => showFilters = !showFilters);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF729BFF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text('Filter'),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: ClipRect(
                  child: showFilters
                      ? Column(
                          children: [
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _buildDropdown(
                                    'Country',
                                    selectedCountry,
                                    countryOptions,
                                    (val) =>
                                        setState(() => selectedCountry = val)),
                                _buildDropdown(
                                    'Field',
                                    selectedField,
                                    fieldOptions,
                                    (val) =>
                                        setState(() => selectedField = val)),
                                _buildDropdown(
                                    'Job Type',
                                    selectedJobType,
                                    jobTypeOptions,
                                    (val) =>
                                        setState(() => selectedJobType = val)),
                                _buildDropdown(
                                    'Industry Type',
                                    selectedIndustryType,
                                    industryTypeOptions,
                                    (val) => setState(
                                        () => selectedIndustryType = val)),
                                _buildDropdown(
                                    'Experience',
                                    selectedExperience,
                                    experienceOptions,
                                    (val) => setState(
                                        () => selectedExperience = val)),
                                _buildDropdown(
                                    'Korean Skill',
                                    selectedKoreanSkill,
                                    koreanSkillOptions,
                                    (val) => setState(
                                        () => selectedKoreanSkill = val)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                print('Country: $selectedCountry');
                                print('Field: $selectedField');
                                print('Job Type: $selectedJobType');
                                print('Industry Type: $selectedIndustryType');
                                print('Experience: $selectedExperience');
                                print('Korean Skill: $selectedKoreanSkill');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4AD0C7),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text('Search'),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: companyList.length,
                  itemBuilder: (context, index) {
                    final company = companyList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CompanyCard(company: company),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 160,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        hint: Text('All $label'),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('All'),
          ),
          ...options.map((opt) => DropdownMenuItem(
                value: opt,
                child: Text(opt),
              )),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
