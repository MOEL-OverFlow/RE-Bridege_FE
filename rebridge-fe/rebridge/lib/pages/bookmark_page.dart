import 'package:flutter/material.dart';
import 'package:rebridge/data/api/Bookmark_api.dart';
import 'package:rebridge/data/api/JobPosting_api.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/company_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  List<JobPosting> _bookmarkedCompanies = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    setState(() {
      _isLoggedIn = token != null;
    });
    if (_isLoggedIn) {
      _loadBookmarkedCompanies();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadBookmarkedCompanies() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final bookmarks = await BookmarkApi.getMyBookmarks();

      setState(() {
        _bookmarkedCompanies = bookmarks;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading bookmarked companies: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                'Bookmarked Posts',
                style: TextStyle(
                  fontSize: DeviceStyles.screenWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: CompanyCard(company: {}, isLoading: true),
                        ),
                      )
                    : _bookmarkedCompanies.isEmpty
                        ? const Center(
                            child: Text('No bookmarked posts yet.'),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadBookmarkedCompanies,
                            child: ListView.builder(
                              itemCount: _bookmarkedCompanies.length,
                              itemBuilder: (context, index) {
                                final company = _bookmarkedCompanies[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: CompanyCard(
                                    company: {
                                      'name': company.companyName,
                                      'field': company.field,
                                      'jobType': company.jobType,
                                      'url': company.detailUrl,
                                      'industryType': company.industryType,
                                      'country': company.nation,
                                      'recruit':
                                          company.recruitmentCount.toString(),
                                      'experience': company.experience,
                                      'koreanSkill': company.koreanSkillLevel,
                                      'deadline': company.deadline,
                                      'bookMark': 'true',
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
