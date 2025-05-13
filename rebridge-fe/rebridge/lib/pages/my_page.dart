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

  static const List<String> nationOptions = [
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

  static const List<String> fieldOptions = [
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
                                  onTap: () {},
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
                                                  fit: BoxFit.cover),
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
                                const Text('현재 이메일',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
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
    BuildContext context,
    WidgetRef ref,
    String title,
    String value, {
    required String field,
  }) {
    return _buildInfoTile(
      context,
      title,
      value,
      onTap: () async {
        final current = ref.read(userRegisterProvider);
        if (current == null) return;

        Future<void> showStyledDialog(
            Widget content, VoidCallback onSave) async {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFFe9eeff),
              title: Center(
                child: Text(
                  '$title 수정',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DeviceStyles.screenWidth(context) * 0.045,
                  ),
                ),
              ),
              content: content,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: DeviceStyles.screenWidth(context) * 0.25,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('취소'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: DeviceStyles.screenWidth(context) * 0.25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C68FF),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onSave();
                        },
                        child: const Text(
                          '저장',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }

        if (field == 'birth') {
          final selected = await showDatePicker(
            context: context,
            initialDate: DateTime.tryParse(current.birth) ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFF4C68FF)),
              ),
              child: child!,
            ),
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
          String? primary = current.primaryIndustry;
          String? secondary = current.secondaryIndustry;

          await showStyledDialog(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: primary,
                  decoration: const InputDecoration(labelText: '관심업종 1'),
                  items: MyPage.fieldOptions
                      .map((opt) =>
                          DropdownMenuItem(value: opt, child: Text(opt)))
                      .toList(),
                  onChanged: (val) => primary = val,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: secondary,
                  decoration: const InputDecoration(labelText: '관심업종 2'),
                  items: MyPage.fieldOptions
                      .map((opt) =>
                          DropdownMenuItem(value: opt, child: Text(opt)))
                      .toList(),
                  onChanged: (val) => secondary = val,
                ),
              ],
            ),
            () async {
              if (primary != null && secondary != null) {
                final success =
                    await UserApi.updateFields(primary!, secondary!);
                if (success) {
                  ref.read(userRegisterProvider.notifier).state =
                      current.copyWith(
                    primaryIndustry: primary,
                    secondaryIndustry: secondary,
                  );
                }
              }
            },
          );
        } else if (field == 'nationality') {
          String? selected = current.nationality;

          await showStyledDialog(
            DropdownButtonFormField<String>(
              value: selected,
              isExpanded: true,
              decoration: const InputDecoration(labelText: '국가 선택'),
              items: MyPage.nationOptions
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => selected = val,
            ),
            () async {
              if (selected != null) {
                final success = await UserApi.updateNation(selected!);
                if (success) {
                  ref.read(userRegisterProvider.notifier).state =
                      current.copyWith(nationality: selected);
                }
              }
            },
          );
        } else if (field == 'password') {
          final controller = TextEditingController();

          await showStyledDialog(
            TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '새 비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            () async {
              final result = controller.text.trim();
              if (result.isNotEmpty) {
                final success = await UserApi.updatePassword(result);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
                  );
                }
              }
            },
          );
        } else {
          final controller = TextEditingController(text: value);

          await showStyledDialog(
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '입력값',
                border: OutlineInputBorder(),
              ),
            ),
            () async {
              final result = controller.text.trim();
              if (result.isNotEmpty) {
                bool success = false;
                if (field == 'fullName') {
                  success = await UserApi.updateName(result, context);
                  if (success) {
                    ref.read(userRegisterProvider.notifier).state =
                        current.copyWith(fullName: result);
                  }
                }
              }
            },
          );
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
