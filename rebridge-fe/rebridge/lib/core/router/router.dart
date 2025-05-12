import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/pages/agree_terms_page.dart';
import 'package:rebridge/pages/checklist_page.dart';
import 'package:rebridge/pages/company_list_page.dart';
import 'package:rebridge/pages/final_user_register_page.dart';
import 'package:rebridge/pages/find_ID_page.dart';
import 'package:rebridge/pages/find_PW_page.dart';
import 'package:rebridge/pages/first_user_reigster_page.dart';
import 'package:rebridge/pages/membership_guide2_page.dart';
import 'package:rebridge/pages/membership_guide_page.dart';
import 'package:rebridge/pages/my_page.dart';
import 'package:rebridge/pages/safetymaterial_page.dart';
import 'package:rebridge/pages/second_user_register_page.dart';
import '../../pages/login_page.dart';
import '../../pages/splash_page.dart';
import '../../pages/home_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(path: '/findId', builder: (context, state) => const FindIdPage()),
      GoRoute(path: '/findPw', builder: (context, state) => const FindPWPage()),
      GoRoute(
          path: '/membershipguide',
          builder: (context, state) => const MembershipGuidePage()),
      GoRoute(
          path: '/membershipguide2',
          builder: (context, state) => const MembershipGuide2Page()),
      GoRoute(
          path: '/agreeterms',
          builder: (context, state) => const AgreeTermsPage()),
      GoRoute(
          path: '/firstRegister',
          builder: (context, state) => const FirstUserRegisterPage()),
      GoRoute(
          path: '/secondRegister',
          builder: (context, state) => const SecondUserRegisterPage()),
      GoRoute(
          path: '/finalRegister',
          builder: (context, state) => const FinalUserRegisterPage()),
      GoRoute(
          path: '/checklists',
          builder: (context, state) => const ChecklistPage()),
      GoRoute(path: '/mypage', builder: (context, state) => const MyPage()),
      GoRoute(
          path: '/safetypage',
          builder: (context, state) => const SafetyMaterialPage()),
      GoRoute(
          path: '/companylists',
          builder: (context, state) => const CompanyListPage())
    ],
  );
});
