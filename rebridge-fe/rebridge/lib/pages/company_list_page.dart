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
      companyList = postings.map((e) => _mapPosting(e)).toList();
      isLoading = false;
    });
  }

  Future<void> _filterJobPostings() async {
    setState(() => isLoading = true);
    final filtered = await JobPostingApi.fetchFilteredJobs(
      field: selectedField,
      jobType: selectedJobType,
      industryType: selectedIndustryType,
      nation: selectedCountry,
      experience: selectedExperience,
      koreanSkillLevel: selectedKoreanSkill,
    );
    setState(() {
      companyList = filtered.map((e) => _mapPosting(e)).toList();
      currentPage = 1;
      isLoading = false;
    });
  }

  Map<String, String> _mapPosting(JobPosting e) => {
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
      };

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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Filter Options',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                            'Country',
                            selectedCountry,
                            countryOptions,
                            (val) =>
                                setModalState(() => selectedCountry = val)),
                        const SizedBox(height: 12),
                        _buildDropdown('Field', selectedField, fieldOptions,
                            (val) => setModalState(() => selectedField = val)),
                        const SizedBox(height: 12),
                        _buildDropdown(
                            'Job Type',
                            selectedJobType,
                            jobTypeOptions,
                            (val) =>
                                setModalState(() => selectedJobType = val)),
                        const SizedBox(height: 12),
                        _buildDropdown(
                            'Industry Type',
                            selectedIndustryType,
                            industryTypeOptions,
                            (val) => setModalState(
                                () => selectedIndustryType = val)),
                        const SizedBox(height: 12),
                        _buildDropdown(
                            'Experience',
                            selectedExperience,
                            experienceOptions,
                            (val) =>
                                setModalState(() => selectedExperience = val)),
                        const SizedBox(height: 12),
                        _buildDropdown(
                            'Korean Skill',
                            selectedKoreanSkill,
                            koreanSkillOptions,
                            (val) =>
                                setModalState(() => selectedKoreanSkill = val)),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop(); // 닫고 필터링 실행
                              await _filterJobPostings();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4AD0C7),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Apply Filter'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
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

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: DeviceStyles.screenWidth(context) * 0.8,
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
