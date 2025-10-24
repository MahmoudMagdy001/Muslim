import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/format_helper.dart';
import 'crops_zakat_tab.dart';
import 'zakat_card_widget.dart';

// ==================== Main Calculator Widget ====================
class ZakatCalculator extends StatefulWidget {
  const ZakatCalculator({super.key});

  @override
  State<ZakatCalculator> createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends State<ZakatCalculator>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  double? goldPricePerGram;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchGoldPrice();
  }

  Future<void> fetchGoldPrice() async {
    const apiUrl = 'https://www.goldapi.io/api/XAU/EGP';
    const apiKey = 'goldapi-l32r3smh52b689-io';

    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await http
          .get(Uri.parse(apiUrl), headers: {'x-access-token': apiKey})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          goldPricePerGram = data['price_gram_21k']?.toDouble() ?? 0.0;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'تعذر جلب سعر الذهب. الرجاء المحاولة لاحقاً.';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'خطأ في الاتصال بالإنترنت. تأكد من اتصالك بالشبكة.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (isLoading) {
      return Scaffold(
        appBar: _buildAppBar(textTheme, theme),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text('جاري تحميل سعر الذهب...', style: textTheme.bodyLarge),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null ||
        goldPricePerGram == null ||
        goldPricePerGram == 0) {
      return Scaffold(
        appBar: _buildAppBar(textTheme, theme),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  errorMessage ?? 'تعذر تحميل سعر الذهب',
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: fetchGoldPrice,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة المحاولة'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    const nisabGoldGrams = 85;
    final nisabMoney = nisabGoldGrams * goldPricePerGram!;

    return Scaffold(
      appBar: _buildAppBar(textTheme, theme),
      body: TabBarView(
        controller: _tabController,
        children: [
          MoneyZakatTab(nisabMoney: nisabMoney),
          GoldZakatTab(goldPricePerGram: goldPricePerGram!),
          TradeZakatTab(nisabMoney: nisabMoney),
          const CropsZakatTab(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(TextTheme textTheme, ThemeData theme) => AppBar(
    title: const Text('حاسبة الزكاة'),

    actions: [
      IconButton(
        onPressed: fetchGoldPrice,
        icon: const Icon(Icons.refresh),
        tooltip: 'تحديث سعر الذهب',
      ),
    ],
    bottom: TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'المال'),
        Tab(text: 'الذهب'),
        Tab(text: 'التجارة'),
        Tab(text: 'الزروع'),
      ],
    ),
  );
}

// ==================== Tabs Implementations ====================
class MoneyZakatTab extends StatelessWidget {
  const MoneyZakatTab({required this.nisabMoney, super.key});
  final double nisabMoney;

  @override
  Widget build(BuildContext context) => ZakatCard(
    title: '💰 زكاة المال',
    description:
        'تجب الزكاة في المال إذا بلغ النصاب (${convertToArabicNumbers(nisabMoney.toStringAsFixed(0))} جنيه تقريبًا) ومر عليه حول قمري كامل.\n\nالنسبة: ${convertToArabicNumbers('2.5')}% من إجمالي المال المدخر',
    hintText: 'أدخل إجمالي المال المدخر بالجنيه',
    calculate: (input) => (double.tryParse(input) ?? 0) * 0.025,
  );
}

class GoldZakatTab extends StatelessWidget {
  const GoldZakatTab({required this.goldPricePerGram, super.key});
  final double goldPricePerGram;

  @override
  Widget build(BuildContext context) => ZakatCard(
    title: '🪙 زكاة الذهب',
    description:
        'النصاب في الذهب هو ${convertToArabicNumbers('85')} جرام.\nالنسبة: ${convertToArabicNumbers('2.5')}% من القيمة السوقية للذهب.\n\nسعر الجرام الحالي: ${convertToArabicNumbers(goldPricePerGram.toStringAsFixed(2))} جنيه',
    hintText: 'أدخل وزن الذهب بالجرام',
    calculate: (input) {
      final grams = double.tryParse(input) ?? 0;
      return grams * goldPricePerGram * 0.025;
    },
  );
}

class TradeZakatTab extends StatelessWidget {
  const TradeZakatTab({required this.nisabMoney, super.key});
  final double nisabMoney;

  @override
  Widget build(BuildContext context) => ZakatCard(
    title: '🛍️ زكاة التجارة',
    description:
        'تحسب الزكاة على: (قيمة البضائع + النقد - الديون) × ${convertToArabicNumbers('2.5')}%\n\nتجب بعد مرور الحول.\nالنصاب: ${convertToArabicNumbers(nisabMoney.toStringAsFixed(0))} جنيه',
    hintText: 'أدخل صافي أصول التجارة بالجنيه',
    calculate: (input) => (double.tryParse(input) ?? 0) * 0.025,
  );
}
