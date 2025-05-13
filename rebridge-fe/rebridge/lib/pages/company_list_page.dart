import 'package:flutter/material.dart';
import 'package:rebridge/data/api/JobPosting_api.dart';
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
  List<Map<String, String>> companyList = [];
  bool isLoading = true;
  int currentPage = 1;
  final int itemsPerPage = 10;

  String? selectedCountry;
  String? selectedField;
  String? selectedJobType;
  String? selectedIndustryType;
  String? selectedExperience;
  String? selectedKoreanSkill;

  bool showFilters = false;

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
    'TRANSPORT',
    'NONE'
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

  @override
  void initState() {
    super.initState();
    _fetchJobPostings();
  }

  Future<void> _fetchJobPostings() async {
    final postings = await JobPostingApi.fetchJobPostings();
    setState(() {
      companyList = postings
          .map((e) => {
                'id': e.id.toString(),
                'name': e.companyName,
                'field': e.field,
                'jobType': e.jobType,
                'url': e.detailUrl,
                'industryType': e.industryType,
                'country': e.nation,
                'recruit': e.recruitmentCount.toString(),
                'experience': e.experience,
                'koreanSkill': e.koreanSkillLevel,
                'deadline': e.deadline,
                'bookMark': e.isBookmark.toString(),
              })
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (companyList.length / itemsPerPage).ceil();
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex =
        (startIndex + itemsPerPage).clamp(0, companyList.length);
    final List<Map<String, String>> pagedCompanyList =
        companyList.sublist(startIndex, endIndex);

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
              _buildFilterButton(context),
              _buildFilterSection(),
              const SizedBox(height: 16),
              Expanded(
                child: isLoading
                    ? ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: CompanyCard(company: {}, isLoading: true),
                        ),
                      )
                    : ListView.builder(
                        itemCount: pagedCompanyList.length,
                        itemBuilder: (context, index) {
                          final company = pagedCompanyList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CompanyCard(company: company),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              if (!isLoading) _buildPagination(totalPages),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() => showFilters = !showFilters);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ButtonStyles.buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ButtonStyles.paddingwidth(context),
            vertical: ButtonStyles.paddingheight(context),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ButtonStyles.borderradius(context)),
          ),
          elevation: 0,
        ),
        child: const Text('Filter'),
      ),
    );
  }

  Widget _buildFilterSection() {
    return AnimatedSize(
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
                      _buildDropdown('Country', selectedCountry, countryOptions,
                          (val) => setState(() => selectedCountry = val)),
                      _buildDropdown('Field', selectedField, fieldOptions,
                          (val) => setState(() => selectedField = val)),
                      _buildDropdown(
                          'Job Type',
                          selectedJobType,
                          jobTypeOptions,
                          (val) => setState(() => selectedJobType = val)),
                      _buildDropdown(
                          'Industry Type',
                          selectedIndustryType,
                          industryTypeOptions,
                          (val) => setState(() => selectedIndustryType = val)),
                      _buildDropdown(
                          'Experience',
                          selectedExperience,
                          experienceOptions,
                          (val) => setState(() => selectedExperience = val)),
                      _buildDropdown(
                          'Korean Skill',
                          selectedKoreanSkill,
                          koreanSkillOptions,
                          (val) => setState(() => selectedKoreanSkill = val)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                  ),
                ],
              )
            : const SizedBox.shrink(),
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
          const DropdownMenuItem<String>(value: null, child: Text('All')),
          ...options
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt))),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final pageNum = index + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  currentPage = pageNum;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: currentPage == pageNum
                    ? Colors.grey
                    : ButtonStyles.buttonColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(36, 36),
              ),
              child: Text('$pageNum'),
            ),
          );
        }),
      ),
    );
  }
}
