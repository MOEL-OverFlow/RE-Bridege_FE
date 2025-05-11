import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import '../../../shared/providers/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceStyles.screenWidth(context) * 0.08,
            vertical: DeviceStyles.screenHeight(context) * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
              GestureDetector(
                onTap: () {
                  context.push('/mypage');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
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
                              const CircleAvatar(
                                radius: 32,
                                backgroundColor: Color(0xFFE6EEFF),
                                child: Icon(Icons.person,
                                    size: 32, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.flag, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Full Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          DeviceStyles.screenWidth(context) *
                                              0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Industry of Interest',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        DeviceStyles.screenWidth(context) *
                                            0.04,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text('1. industry 1'),
                                const Text('2. industry 2'),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // 북마크 버튼 기능 구현
                          },
                          icon: const Icon(Icons.bookmark_border),
                          label: const Text('Bookmark Post'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF0F3FF),
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recommended Job Postings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('현지업체명'),
                        Text('업종 대분류'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('🇰🇷 근무 국가'),
                        Text('업종 소분류'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('필요 인원 수'),
                        Text('기간'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 채용 공고 페이지 이동
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF729BFF),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('채용 공고'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/checklists');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4AD0C7),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('체크리스트'),
                  )
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://chatgpt.com/g/g-682079f85e04819184b0b62a07edf568-godeuraegon'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/chatbot_logo.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Go to Chat Bot',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
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
