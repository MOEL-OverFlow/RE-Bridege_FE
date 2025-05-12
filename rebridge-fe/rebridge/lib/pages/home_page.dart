import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 아이콘 + Re:Bridge
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

            // 스크롤 가능한 나머지 내용
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
                      onTap: () {
                        context.push('/mypage');
                      },
                      child: _buildProfileCard(context),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.03),
                    const Text(
                      'Recommended Job Postings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    _buildJobCard(context),
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

  Widget _buildProfileCard(BuildContext context) {
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
                    child: Icon(Icons.person,
                        size: DeviceStyles.screenWidth(context) * 0.08,
                        color: Colors.grey),
                  ),
                  SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                  Row(
                    children: [
                      Icon(Icons.flag,
                          size: DeviceStyles.screenWidth(context) * 0.05),
                      SizedBox(
                          width: DeviceStyles.screenWidth(context) * 0.005),
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: DeviceStyles.screenWidth(context) * 0.035,
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
                      'Industry of Interest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceStyles.screenWidth(context) * 0.04,
                      ),
                    ),
                    SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                    const Text('1. industry 1'),
                    const Text('2. industry 2'),
                  ],
                ),
              )
            ],
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
                padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildJobCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ButtonStyles.borderradius(context)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('현지업체명'), Text('업종 대분류')],
          ),
          SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('🇰🇷 근무 국가'), Text('업종 소분류')],
          ),
          SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('필요 인원 수'), Text('기간')],
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
            // 채용 공고 페이지 이동
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
          child: const Text('채용 공고'),
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
          child: const Text('체크리스트'),
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
