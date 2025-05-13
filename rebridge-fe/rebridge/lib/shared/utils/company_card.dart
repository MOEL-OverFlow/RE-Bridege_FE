import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rebridge/shared/styles/button_style.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:rebridge/shared/utils/skeletonLine.dart';

class CompanyCard extends StatefulWidget {
  final Map<String, String> company;
  final bool isLoading;

  const CompanyCard({
    super.key,
    required this.company,
    this.isLoading = false,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.company['bookMark'] == 'true';
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      widget.company['bookMark'] = isBookmarked.toString();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBookmarked ? 'Added to bookmarks' : 'Removed from bookmarks',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String formatEnumValue(String? value) {
    if (value == null || value.isEmpty) return '';
    return value
        .toLowerCase()
        .split('_')
        .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  Widget _infoRow(IconData icon, String? value, BuildContext context) {
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
            child: widget.isLoading
                ? const SkeletonLine(width: 30, height: 20)
                : Text(
                    value ?? '',
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
    final company = widget.company;

    return Container(
      padding: EdgeInsets.all(DeviceStyles.screenWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ButtonStyles.borderradius(context)),
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
                child: widget.isLoading
                    ? const SkeletonLine(width: 120, height: 20)
                    : Text(
                        company['name'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              const SizedBox(width: 8),
              widget.isLoading
                  ? const SkeletonLine(width: 40, height: 10)
                  : Text(
                      company['field'] ?? '',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 10,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 8),

          // 정보
          _infoRow(Icons.flag, 'Country: ${company['country']}', context),
          _infoRow(Icons.work_outline,
              'Job Type: ${formatEnumValue(company['jobType'])}', context),
          _infoRow(
              Icons.factory,
              'Industry Type: ${formatEnumValue(company['industryType'])}',
              context),
          _infoRow(Icons.timeline,
              'Experience: ${formatEnumValue(company['experience'])}', context),
          _infoRow(
              Icons.language,
              'Korean Skill: ${formatEnumValue(company['koreanSkill'])}',
              context),
          _infoRow(Icons.calendar_today, 'Deadline: ${company['deadline']}',
              context),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final rawUrl = company['url'];
                  if (rawUrl != null && rawUrl.isNotEmpty) {
                    try {
                      // URL 정규화
                      String cleanedUrl = rawUrl.trim();
                      cleanedUrl = cleanedUrl.replaceAll('&amp;', '&');

                      // URL이 http:// 또는 https://로 시작하지 않는 경우 https:// 추가
                      if (!cleanedUrl.startsWith('http://') &&
                          !cleanedUrl.startsWith('https://')) {
                        cleanedUrl = 'https://$cleanedUrl';
                      }

                      // 직접 외부 브라우저로 열기
                      final uri = Uri.parse(cleanedUrl);
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Failed to open URL: ${e.toString()}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No URL available'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.link),
                label: const Text('Detail Link'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF729BFF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
              IconButton(
                onPressed: toggleBookmark,
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blueAccent : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
