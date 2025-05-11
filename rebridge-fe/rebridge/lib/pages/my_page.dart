import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/providers/auth_provider.dart';
import 'package:rebridge/shared/utils/dialog_cancel_util.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  '회원 정보',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: DeviceStyles.screenWidth(context) * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA5B4FC),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(Icons.image,
                                        size: 50, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '이미지를 클릭하면 이미지를\n수정할 수 있습니다',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '현재 이메일',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'howeve18@gmail.com',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoTile(context, '이름', '김현수'),
                      _buildInfoTile(context, '생년월일', '1999.09.27'),
                      _buildInfoTile(context, '국가', '대한민국'),
                      _buildInfoTile(context, '관심업종', 'IT / 요식업'),
                      _buildInfoTile(context, '비밀번호 변경', '', hasArrow: true),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final result =
                                  await DialogCancelUtil.showCancelCustomDialog(
                                context,
                                title: '로그아웃',
                                content: '정말 로그아웃 하시겠습니까?',
                              );

                              if (result) {
                                await ref.read(authProvider.notifier).logout();
                                if (context.mounted) {
                                  context.go('/login');
                                }
                              }
                            },
                            child: const Text(
                              '로그아웃',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          const Text('|'),
                          TextButton(
                            onPressed: () {
                              // 회원 탈퇴 로직
                            },
                            child: const Text(
                              '회원탈퇴',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String title, String value,
      {bool hasArrow = true}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: const TextStyle(fontSize: 14)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (value.isNotEmpty)
                Text(
                  value,
                  style: const TextStyle(color: Colors.black54),
                ),
              if (hasArrow)
                const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
          onTap: () {
            // 항목 클릭 시 동작 (예: 정보 수정)
          },
        ),
        const Divider(),
      ],
    );
  }
}
