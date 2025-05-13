import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
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
            SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'User Info',
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
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceStyles.screenWidth(context) * 0.06,
                    vertical: DeviceStyles.screenHeight(context) * 0.01,
                  ),
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
                                      borderRadius: BorderRadius.circular(
                                          DeviceStyles.screenWidth(context) *
                                              0.04),
                                    ),
                                    padding: EdgeInsets.all(
                                        DeviceStyles.screenWidth(context) *
                                            0.02),
                                    child: Container(
                                      width: DeviceStyles.screenWidth(context) *
                                          0.24,
                                      height:
                                          DeviceStyles.screenHeight(context) *
                                              0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            ButtonStyles.borderradius(context)),
                                      ),
                                      child: user?.imagePath != null &&
                                              user!.imagePath.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ButtonStyles.borderradius(
                                                          context)),
                                              child: Image.network(
                                                  user.imagePath,
                                                  fit: BoxFit.cover),
                                            )
                                          : Icon(Icons.image,
                                              size: DeviceStyles.screenWidth(
                                                      context) *
                                                  0.12,
                                              color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: DeviceStyles.screenHeight(context) *
                                        0.01),
                                Text(
                                  'Click on the image \nto edit the image',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          DeviceStyles.screenWidth(context) *
                                              0.025),
                                ),
                              ],
                            ),
                            SizedBox(
                                width:
                                    DeviceStyles.screenWidth(context) * 0.15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                    height: DeviceStyles.screenHeight(context) *
                                        0.01),
                                Text(
                                  user?.email ?? 'No Email',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize:
                                        DeviceStyles.screenWidth(context) *
                                            0.03,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: DeviceStyles.screenHeight(context) * 0.01),
                      _buildEditableTile(
                          context, ref, 'Name', user?.fullName ?? '',
                          field: 'fullName'),
                      _buildEditableTile(
                          context, ref, 'Birth', user?.birth ?? '',
                          field: 'birth'),
                      _buildEditableTile(
                          context, ref, 'Nation', user?.nationality ?? '',
                          field: 'nationality'),
                      _buildEditableTile(context, ref, 'Industry of interest',
                          '${user?.primaryIndustry ?? ''} / ${user?.secondaryIndustry ?? ''}',
                          field: 'industry'),
                      _buildEditableTile(context, ref, 'Change Password', '',
                          field: 'password'),
                      SizedBox(
                          height: DeviceStyles.screenHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final result =
                                  await DialogCancelUtil.showCancelCustomDialog(
                                context,
                                title: 'Logout',
                                content: 'Are you sure you want to log out?',
                              );
                              if (result) {
                                await ref.read(authProvider.notifier).logout();
                                if (context.mounted) context.go('/login');
                              }
                            },
                            child: const Text('Log Out',
                                style: TextStyle(color: Colors.black54)),
                          ),
                          const Text('|'),
                          TextButton(
                            onPressed: () async {
                              final result =
                                  await DialogCancelUtil.showCancelCustomDialog(
                                context,
                                title: 'Withdraw Membership',
                                content: 'Are you sure you want to withdraw?',
                              );
                              if (result) {
                                final success =
                                    await UserApi.deactivateUser(context);
                                if (success && context.mounted) {
                                  await ref
                                      .read(authProvider.notifier)
                                      .logout();
                                  context.go('/login');
                                }
                              }
                            },
                            child: const Text('Withdraw\nMembership',
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
                  '$title Edit',
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel',
                            style: TextStyle(color: Color(0xFF4C68FF))),
                      ),
                    ),
                    SizedBox(width: DeviceStyles.screenWidth(context) * 0.03),
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
                          'Save',
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
            final success = await UserApi.updateBirthDate(formatted, context);
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
                  decoration:
                      const InputDecoration(labelText: 'Primary Industry'),
                  items: MyPage.fieldOptions
                      .map((opt) =>
                          DropdownMenuItem(value: opt, child: Text(opt)))
                      .toList(),
                  onChanged: (val) => primary = val,
                ),
                SizedBox(height: DeviceStyles.screenHeight(context) * 0.01),
                DropdownButtonFormField<String>(
                  value: secondary,
                  decoration:
                      const InputDecoration(labelText: 'Secondary Industry'),
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
                    await UserApi.updateFields(primary!, secondary!, context);
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
              decoration: const InputDecoration(labelText: 'Choose Nation'),
              items: MyPage.nationOptions
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => selected = val,
            ),
            () async {
              if (selected != null) {
                final success = await UserApi.updateNation(selected!, context);
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
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            () async {
              final result = controller.text.trim();
              if (result.isNotEmpty) {
                await UserApi.updatePassword(result, context);
              }
            },
          );
        } else {
          final controller = TextEditingController(text: value);

          await showStyledDialog(
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Input Value',
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
          title: Text(title,
              style: TextStyle(
                  fontSize: DeviceStyles.screenWidth(context) * 0.03)),
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
