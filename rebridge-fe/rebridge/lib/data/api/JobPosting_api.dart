import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rebridge/shared/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPosting {
  final int id;
  final String companyName;
  final String field;
  final String jobType;
  final String detailUrl;
  final String industryType;
  final String nation;
  final int recruitmentCount;
  final String experience;
  final String koreanSkillLevel;
  final String deadline;
  final bool isBookmark;

  JobPosting({
    required this.id,
    required this.companyName,
    required this.field,
    required this.jobType,
    required this.detailUrl,
    required this.industryType,
    required this.nation,
    required this.recruitmentCount,
    required this.experience,
    required this.koreanSkillLevel,
    required this.deadline,
    required this.isBookmark,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      id: json['jobPostingId'] ?? json['id'],
      companyName: json['companyName'],
      field: json['field'],
      jobType: json['jobType'],
      detailUrl: json['detailUrl'],
      industryType: json['industryType'],
      nation: json['nation'],
      recruitmentCount: json['recruitmentCount'],
      experience: json['experience'],
      koreanSkillLevel: json['koreanSkillLevel'],
      deadline: json['deadline'],
      isBookmark: json['isBookmark'],
    );
  }

  JobPosting copyWith({
    int? id,
    String? companyName,
    String? field,
    String? jobType,
    String? detailUrl,
    String? industryType,
    String? nation,
    int? recruitmentCount,
    String? experience,
    String? koreanSkillLevel,
    String? deadline,
    bool? isBookmark,
  }) {
    return JobPosting(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      field: field ?? this.field,
      jobType: jobType ?? this.jobType,
      detailUrl: detailUrl ?? this.detailUrl,
      industryType: industryType ?? this.industryType,
      nation: nation ?? this.nation,
      recruitmentCount: recruitmentCount ?? this.recruitmentCount,
      experience: experience ?? this.experience,
      koreanSkillLevel: koreanSkillLevel ?? this.koreanSkillLevel,
      deadline: deadline ?? this.deadline,
      isBookmark: isBookmark ?? this.isBookmark,
    );
  }
}

class JobPostingApi {
  static List<JobPosting> _cachedJobPostings = [];

  static Future<List<JobPosting>> fetchJobPostings() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found. Please log in again.');
    }

    final response = await http.get(
      Uri.parse('${Address.baseUrl}/job-postings'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _cachedJobPostings = data.map((e) => JobPosting.fromJson(e)).toList();
      return _cachedJobPostings;
    } else {
      throw Exception('Failed to load job postings: ${response.body}');
    }
  }

  static Future<List<JobPosting>> fetchRandomJob() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found. Please log in again.');
    }

    final response = await http.get(
      Uri.parse('${Address.baseUrl}/job-postings/recommend'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _cachedJobPostings = data.map((e) => JobPosting.fromJson(e)).toList();
      return _cachedJobPostings;
    } else {
      throw Exception(
          'Failed to load recommended job postings: ${response.body}');
    }
  }

  static Future<List<JobPosting>> fetchFilteredJobs({
    String? field,
    String? jobType,
    String? industryType,
    String? nation,
    String? experience,
    String? koreanSkillLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found. Please log in again.');
    }

    final response = await http.post(
      Uri.parse('${Address.baseUrl}/job-postings/filtering'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'field': field,
        'jobType': jobType,
        'industryType': industryType,
        'nation': nation,
        'experience': experience,
        'koreanSkillLevel': koreanSkillLevel,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => JobPosting.fromJson(e)).toList();
    } else {
      throw Exception('Failed to filter job postings: ${response.body}');
    }
  }
}
