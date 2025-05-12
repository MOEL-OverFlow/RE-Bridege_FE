import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebridge/shared/styles/background_styles.dart';
import 'package:rebridge/shared/styles/device_styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SafetyMaterialPage extends StatefulWidget {
  const SafetyMaterialPage({super.key});

  @override
  State<SafetyMaterialPage> createState() => _SafetyMaterialPageState();
}

class _SafetyMaterialPageState extends State<SafetyMaterialPage> {
  final List<String> languages = [
    'Chinese',
    'Vietnamese',
    'Thai',
    'Uzbek',
    'English',
    'Nepali',
    'Korean'
  ];
  String? selectedLanguage;
  List<String> pdfFiles = [];

  @override
  void initState() {
    super.initState();
  }

  void _loadPdfList(String language) async {
    final mockPdfMap = {
      'Chinese': [
        '建筑工地防坠落卡片手册.pdf',
        '硫化氢中毒——污水检查中的悲剧案例.pdf',
        '所有工作场所的十大安全与健康守则.pdf',
        '熔融电镀行业的安全与健康指南.pdf',
        '作业前安全检查指南——工程车辆设备.pdf',
        '制造业防夹卡片手册.pdf',
        '爆炸物安全处理指南.pdf',
        'LOTO 安全操作程序指南.pdf'
      ],
      'Vietnamese': [
        '10 quy tắc an toàn và sức khỏe hàng đầu cho mọi nơi làm việc.pdf',
        'An toàn và sức khỏe trong ngành xi mạ nóng chảy.pdf',
        'Hướng dẫn quy trình làm việc an toàn với LOTO (khóa và gắn thẻ).pdf',
        'Hướng dẫn xử lý an toàn vật liệu nổ.pdf',
        'Pre-Operation Safety Inspection Guide – Vehicle Construction Equipment.pdf',
        'Sổ tay phòng ngừa tai nạn kẹp:mắc trong ngành sản xuất.pdf',
        'Sổ tay phòng ngừa tai nạn ngã tại công trường xây dựng.pdf',
        'Trường hợp ngộ độc khí hydro sunfua trong quá trình kiểm tra cống thoát nước.pdf',
        'Từ điển Hàn-Việt về An toàn và Sức khỏe nghề nghiệp.pdf'
      ],
      'Thai': [
        '10 กฎความปลอดภัยในที่ทำงาน.pdf',
        'การจัดการวัตถุระเบิด.pdf',
        'การป้องกันการหนีบในโรงงาน.pdf',
        'การป้องกันตกจากที่สูง.pdf',
        'ความปลอดภัยในงานชุบโลหะ.pdf',
        'คู่มือ LOTO.pdf',
        'ตรวจความปลอดภัยรถก่อนใช้งาน.pdf',
        'เหตุพิษไฮโดรเจนซัลไฟด์.pdf'
      ],
      'Uzbek': [
        'Barcha ish joylari uchun eng muhim 10 ta xavfsizlik va sog‘liqni saqlash qoidalari.pdf',
        'Eritilgan qoplama (plating) sanoatida xavfsizlik va salomatlik.pdf',
        'Ish boshlanishidan oldin qurilish texnikasini xavfsizlik bo‘yicha tekshirish qo‘llanmasi.pdf',
        'Ishlab chiqarishda qisilib qolish bilan bog‘liq baxtsiz hodisalarning oldini olish bo‘yicha kartalar kitobi.pdf',
        'LOTO (qulf va belgi) xavfsizlik tartib-qoidalari bo‘yicha qo‘llanma.pdf',
        'Portlovchi moddalarni xavfsiz boshqarish bo‘yicha qo‘llanma.pdf',
        'Qurilish maydonlarida yiqilishning oldini olish bo‘yicha kartalar kitobi.pdf',
        'Vodorod sulfid bilan zaharlanish – Kanalizatsiya tekshiruvlaridagi fojiali holat.pdf'
      ],
      'English': [
        'Card Book for Fall Prevention on Construction Sites.pdf',
        'Card Book for Preventing Trapping Accidents in Manufacturing.pdf',
        'Hydrogen Sulfide Poisoning – Tragic Case in Sewer Inspection.pdf',
        'LOTO Safety Procedure Guide.pdf',
        'Pre-Operation Safety Inspection Guide – Vehicle Construction Equipment.pdf',
        'Safe Handling Guide for Explosive Materials.pdf',
        'safety and Health for Molten Plating Business.pdf',
        'Top 10 Safety and Health Rules for All Workplaces.pdf'
      ],
      'Nepali': [
        'LOTO सुरक्षा प्रक्रिया.pdf',
        'उद्योगमा थिचिने रोक्न कार्ड.pdf',
        'धातु उद्योग सुरक्षा.pdf',
        'नाली निरीक्षणमा H₂S दुर्घटना.pdf',
        'निर्माण स्थलमा खस्न नदिन कार्ड.pdf',
        'विस्फोटक पदार्थ सुरक्षा.pdf',
        'सबै कार्यस्थल १० नियम.pdf',
        'सवारी निर्माण निरीक्षण.pdf'
      ],
      'Korean': [
        '건설현장 추락예방.pdf',
        '위험물 안전관리수칙(폭발성물질)_OPS.pdf',
        '제조업 끼임예방.pdf',
        '차량계 건설기계 작업 전 안전점검 OPS.pdf',
        '폐수 처리장 점검 중 황화수소 중독에 의한 질식.pdf',
        'LOTO 작업절차 바로알기_OPS.pdf'
      ]
    };

    setState(() {
      selectedLanguage = language;
      pdfFiles = mockPdfMap[language] ?? [];
    });
  }

  void _openPdf(BuildContext context, String pdfName) {
    final fullPath = 'assets/pdfs/$selectedLanguage/$pdfName';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(assetPath: fullPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundStyles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DeviceStyles.screenWidth(context) * 0.08,
              vertical: DeviceStyles.screenHeight(context) * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Safety & Health Materials',
                  style: TextStyle(
                    fontSize: DeviceStyles.screenWidth(context) * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: languages.map((lang) {
                    final isSelected = selectedLanguage == lang;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color(0xFF4A6EFF) // 선택된 버튼 색상
                            : Colors.white, // 비선택 버튼은 흰색
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black87,
                        elevation: isSelected ? 2 : 0,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      onPressed: () => _loadPdfList(lang),
                      child: Text(
                        lang,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                if (selectedLanguage != null)
                  Text(
                    'PDFs for $selectedLanguage',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  height: DeviceStyles.screenHeight(context) * 0.4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pdfFiles.length,
                    itemBuilder: (context, index) {
                      final pdfName = pdfFiles[index];
                      return ListTile(
                        title: Text(
                          pdfName.split('/').last,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.picture_as_pdf),
                        onTap: () => _openPdf(context, pdfName),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String assetPath;

  const PdfViewerPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.asset(assetPath),
    );
  }
}
