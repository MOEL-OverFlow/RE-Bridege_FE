import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/providers/auth_provider.dart';
import 'package:rebridge/shared/providers/user_register_provider.dart';
import 'package:rebridge/shared/utils/dialog_cancel_util.dart';
import 'package:rebridge/data/api/user_api.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userRegisterProvider);

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
                                GestureDetector(
                                  onTap: () {
                                    // TODO: 이미지 수정 기능
                                  },
                                  child: Container(
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
                                      child: user?.imagePath != null &&
                                              user!.imagePath.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                user.imagePath,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Icon(Icons.image,
                                              size: 50, color: Colors.black),
                                    ),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '현재 이메일',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user?.email ?? '이메일 없음',
                                  style: const TextStyle(
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
                      _buildEditableTile(
                          context, ref, '이름', user?.fullName ?? '',
                          field: 'fullName'),
                      _buildEditableTile(
                          context, ref, '생년월일', user?.birth ?? '',
                          field: 'birth'),
                      _buildEditableTile(
                          context, ref, '국가', user?.nationality ?? '',
                          field: 'nationality'),
                      _buildEditableTile(context, ref, '관심업종',
                          '${user?.primaryIndustry ?? ''} / ${user?.secondaryIndustry ?? ''}',
                          field: 'industry'),
                      _buildEditableTile(context, ref, '비밀번호 변경', '',
                          field: 'password'),
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
                                if (context.mounted) context.go('/login');
                              }
                            },
                            child: const Text('로그아웃',
                                style: TextStyle(color: Colors.black54)),
                          ),
                          const Text('|'),
                          TextButton(
                            onPressed: () async {
                              final result =
                                  await DialogCancelUtil.showCancelCustomDialog(
                                context,
                                title: '회원탈퇴',
                                content: '정말 탈퇴하시겠습니까?',
                              );
                              if (result) {
                                final success = await UserApi.deactivateUser();
                                if (success && context.mounted) {
                                  await ref
                                      .read(authProvider.notifier)
                                      .logout();
                                  context.go('/login');
                                }
                              }
                            },
                            child: const Text('회원탈퇴',
                                style: TextStyle(color: Colors.black54)),
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

  Widget _buildEditableTile(
      BuildContext context, WidgetRef ref, String title, String value,
      {required String field}) {
    return _buildInfoTile(
      context,
      title,
      value,
      onTap: () async {
        final current = ref.read(userRegisterProvider);
        if (current == null) return;

        if (field == 'birth') {
          final selected = await showDatePicker(
            context: context,
            initialDate: DateTime.tryParse(current.birth) ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (selected != null) {
            final formatted = selected.toIso8601String().split('T').first;
            final success = await UserApi.updateBirthDate(formatted);
            if (success) {
              ref.read(userRegisterProvider.notifier).state =
                  current.copyWith(birth: formatted);
            }
          }
        } else if (field == 'industry') {
          final primaryController =
              TextEditingController(text: current.primaryIndustry);
          final secondaryController =
              TextEditingController(text: current.secondaryIndustry);

          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('관심업종 수정'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: primaryController,
                    decoration: const InputDecoration(labelText: '관심업종 1'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: secondaryController,
                    decoration: const InputDecoration(labelText: '관심업종 2'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('저장'),
                ),
              ],
            ),
          );

          if (result == true) {
            final success = await UserApi.updateFields(
              primaryController.text.trim(),
              secondaryController.text.trim(),
            );
            if (success) {
              ref.read(userRegisterProvider.notifier).state = current.copyWith(
                primaryIndustry: primaryController.text.trim(),
                secondaryIndustry: secondaryController.text.trim(),
              );
            }
          }
        } else if (field == 'password') {
          final controller = TextEditingController();
          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('새 비밀번호 입력'),
              content: TextField(
                controller: controller,
                obscureText: true,
                decoration: const InputDecoration(hintText: '새 비밀번호'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, controller.text.trim()),
                  child: const Text('저장'),
                ),
              ],
            ),
          );

          if (result != null && result.isNotEmpty) {
            final success = await UserApi.updatePassword(result);
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
              );
            }
          }
        } else {
          final controller = TextEditingController(text: value);
          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('$title 수정'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, controller.text.trim()),
                  child: const Text('저장'),
                ),
              ],
            ),
          );

          if (result != null) {
            bool success = false;
            if (field == 'fullName') {
              success = await UserApi.updateName(result, context);
              if (success)
                ref.read(userRegisterProvider.notifier).state =
                    current.copyWith(fullName: result);
            } else if (field == 'nationality') {
              success = await UserApi.updateNation(result);
              if (success)
                ref.read(userRegisterProvider.notifier).state =
                    current.copyWith(nationality: result);
            }
          }
        }
      },
    );
  }

  Widget _buildInfoTile(BuildContext context, String title, String value,
      {bool hasArrow = true, VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: const TextStyle(fontSize: 14)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (value.isNotEmpty)
                Text(value, style: const TextStyle(color: Colors.black54)),
              if (hasArrow)
                const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
