import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/pages/find_ID_page.dart';
import 'package:rebridge/pages/find_PW_page.dart';
import 'package:rebridge/pages/first_user_reigster_page.dart';
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
          path: '/firstRegister',
          builder: (context, state) => const FirstUserRegisterPage())
    ],
  );
});
