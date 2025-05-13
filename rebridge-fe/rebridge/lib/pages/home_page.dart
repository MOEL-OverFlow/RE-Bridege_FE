import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/data/api/JobPosting_api.dart';
import 'package:rebridge/main.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/company_card.dart';
import 'package:rebridge/shared/utils/skeletonLine.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with RouteAware {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  bool isLoading = false;
  List<Map<String, String>> companySamples = [];

  @override
  void initState() {
    super.initState();
    _loadJobPostings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadJobPostings();
  }

  Future<void> _loadJobPostings() async {
    try {
      isLoading = true;
      final jobPostings = await JobPostingApi.fetchRandomJob();
      List<Map<String, String>> converted = jobPostings.map((job) {
        return {
          'name': job.companyName,
          'field': job.field,
          'country': job.nation,
          'recruit': job.recruitmentCount.toString(),
          'career': job.experience,
          'language': job.koreanSkillLevel,
          'deadline': job.deadline,
          'url': job.detailUrl,
          'jobType': job.jobType,
          'industryType': job.industryType,
          'experience': job.experience,
          'koreanSkill': job.koreanSkillLevel,
          'bookMark': job.isBookmark.toString(),
        };
      }).toList();
      setState(() {
        companySamples = converted;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load job postings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DeviceStyles.screenWidth(context) * 0.08,
                vertical: DeviceStyles.screenHeight(context) * 0.02,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/mascot.png',
                    width: DeviceStyles.screenWidth(context) * 0.08,
                  ),
                  SizedBox(width: DeviceStyles.screenWidth(context) * 0.02),
                  Text(
                    'Re:Bridge',
                    style: TextStyle(
                      fontSize: DeviceStyles.screenWidth(context) * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceStyles.screenWidth(context) * 0.08,
                  vertical: DeviceStyles.screenHeight(context) * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/mypage'),
                      child: _buildProfileCard(context, ref),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
                    const Text(
                      'Recommended Job Postings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    SizedBox(
                      height: DeviceStyles.screenHeight(context) * 0.43,
                      child: isLoading
                          ? _buildLoadingCards()
                          : companySamples.isEmpty
                              ? const Center(
                                  child: Text('No job postings available.'))
                              : Column(
                                  children: [
                                    Expanded(
                                      child: PageView.builder(
                                        controller: _pageController,
                                        itemCount: companySamples.length,
                                        onPageChanged: (index) {
                                          setState(() => _currentPage = index);
                                        },
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  DeviceStyles.screenWidth(
                                                          context) *
                                                      0.01,
                                            ),
                                            child: CompanyCard(
                                              company: companySamples[index],
                                              isLoading: false,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            DeviceStyles.screenHeight(context) *
                                                0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        companySamples.length,
                                        (index) => AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          width: _currentPage == index ? 12 : 8,
                                          height:
                                              _currentPage == index ? 12 : 8,
                                          decoration: BoxDecoration(
                                            color: _currentPage == index
                                                ? const Color(0xFF729BFF)
                                                : Colors.grey.shade400,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
                    _buildButtons(context, ref),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
                    _buildChatBot(context),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
                    _buildSafetyMediaButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, WidgetRef ref,
      {bool isLoading = false}) {
    final user = ref.watch(userRegisterProvider);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ButtonStyles.borderradius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(DeviceStyles.screenWidth(context) * 0.0002),
            blurRadius: ButtonStyles.borderradius(context),
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: DeviceStyles.screenWidth(context) * 0.08,
                    backgroundColor: const Color(0xFFE6EEFF),
                    backgroundImage:
                        isLoading || user?.imagePath.isEmpty != false
                            ? null
                            : NetworkImage(user!.imagePath),
                    child: (isLoading || user?.imagePath.isEmpty != false)
                        ? Icon(Icons.person,
                            size: DeviceStyles.screenWidth(context) * 0.08,
                            color: Colors.grey)
                        : null,
                  ),
                  SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                  Row(
                    children: [
                      Icon(Icons.flag,
                          size: DeviceStyles.screenWidth(context) * 0.05),
                      SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.005),
                      isLoading
                          ? SkeletonLine(
                              width: DeviceStyles.screenWidth(context) * 0.04,
                              height: DeviceStyles.screenHeight(context) * 0.01)
                          : Text(
                              user?.fullName ?? 'No Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    DeviceStyles.screenWidth(context) * 0.035,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: DeviceStyles.screenWidth(context) * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Industry of interest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceStyles.screenWidth(context) * 0.04,
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    isLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                  width:
                                      DeviceStyles.screenWidth(context) * 0.04,
                                  height: DeviceStyles.screenHeight(context) *
                                      0.01),
                              SizedBox(
                                  height: DeviceStyles.screenHeight(context) *
                                      0.01),
                              SkeletonLine(
                                  width:
                                      DeviceStyles.screenWidth(context) * 0.04,
                                  height: DeviceStyles.screenHeight(context) *
                                      0.01),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '1. ${user?.primaryIndustry ?? 'No Primary Industry'}'),
                              Text(
                                  '2. ${user?.secondaryIndustry ?? 'No Secondary Indsutry'}'),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: isLoading
                ? const SkeletonLine(width: 120, height: 14)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('📧 Email: ${user?.email ?? 'No Email'}'),
                      Text('🎂 Birth: ${user?.birth ?? 'No Birth'}'),
                      Text('🌏 Nation: ${user?.nationality ?? 'No Nation'}'),
                    ],
                  ),
          ),
          SizedBox(height: DeviceStyles.screenHeight(context) * 0.02),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
              label: const Text('Bookmark Post'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0F3FF),
                foregroundColor: Colors.black87,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                    horizontal: ButtonStyles.paddingwidth(context),
                    vertical: ButtonStyles.paddingheight(context)),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ButtonStyles.borderradius(context)),
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            context.push('/companylists');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF729BFF),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: ButtonStyles.paddingheight(context),
              horizontal: ButtonStyles.paddingwidth(context) * 2.8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ButtonStyles.borderradius(context)),
            ),
          ),
          child: const Text('Job Postings'),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/checklists');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4AD0C7),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: ButtonStyles.paddingheight(context),
              horizontal: ButtonStyles.paddingwidth(context) * 2.8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ButtonStyles.borderradius(context)),
            ),
          ),
          child: const Text('CheckLists'),
        )
      ],
    );
  }

  Widget _buildChatBot(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
              'https://chatgpt.com/g/g-682079f85e04819184b0b62a07edf568-godeuraegon'),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: ButtonStyles.paddingheight(context),
          horizontal: ButtonStyles.paddingwidth(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(ButtonStyles.borderradius(context)),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/chatbot_logo.png',
                width: DeviceStyles.screenWidth(context) * 0.07,
                height: DeviceStyles.screenHeight(context) * 0.05,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: DeviceStyles.screenWidth(context) * 0.02),
            Text(
              'Go to Chat Bot',
              style: TextStyle(
                fontSize: DeviceStyles.screenWidth(context) * 0.04,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCards() {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.02),
        child: const CompanyCard(
          company: {},
          isLoading: true,
        ),
      ),
    );
  }

  Widget _buildSafetyMediaButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/safetypage');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: ButtonStyles.paddingheight(context),
          horizontal: ButtonStyles.paddingwidth(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(ButtonStyles.borderradius(context)),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/chatbot_logo.png',
                width: DeviceStyles.screenWidth(context) * 0.07,
                height: DeviceStyles.screenHeight(context) * 0.05,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: DeviceStyles.screenWidth(context) * 0.02),
            Text(
              'Safety and Health Media Materials',
              style: TextStyle(
                fontSize: DeviceStyles.screenWidth(context) * 0.04,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
