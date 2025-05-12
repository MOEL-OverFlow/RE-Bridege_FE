import 'package:flutter/material.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/dialog_util.dart';

class CompanyCard extends StatelessWidget {
  final Map<String, String> company;

  const CompanyCard({super.key, required this.company});

  String formatEnumValue(String? value) {
    if (value == null || value.isEmpty) return '';
    return value
        .toLowerCase()
        .split('_')
        .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  Widget _infoRow(IconData icon, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: DeviceStyles.screenWidth(context) * 0.04,
              color: Colors.black54),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DialogUtil.showCustomDialog(
          context,
          title: company['name'] ?? 'Detail',
          content: 'More information about ${company['name'] ?? ''}',
        );
      },
      child: Container(
        padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(ButtonStyles.borderradius(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    company['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  company['field'] ?? '',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 정보 라인
            _infoRow(
                Icons.flag, 'Country: ${company['country'] ?? ''}', context),
            _infoRow(Icons.work_outline,
                'Job Type: ${formatEnumValue(company['jobType'])}', context),
            _infoRow(
                Icons.factory,
                'Industry Type: ${formatEnumValue(company['industryType'])}',
                context),
            _infoRow(
                Icons.timeline,
                'Experience: ${formatEnumValue(company['experience'])}',
                context),
            _infoRow(
                Icons.language,
                'Korean Skill: ${formatEnumValue(company['koreanSkill'])}',
                context),
            _infoRow(Icons.calendar_today,
                'Deadline: ${company['deadline'] ?? ''}', context),
          ],
        ),
      ),
    );
  }
}
