// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_state_manager/internet_state_manager.dart';

import '../../../../core/utils/custom_loading_indicator.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'crops_zakat_tab.dart';
import 'zakat_card.dart';

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
    const goldApiUrl = 'https://api.gold-api.com/price/XAU';
    const exchangeApiUrl =
        'https://v6.exchangerate-api.com/v6/1ee47c1bb5322848794692ee/latest/USD';

    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // --- 1️⃣ جلب سعر الذهب بالدولار ---
      final goldResponse = await http
          .get(Uri.parse(goldApiUrl))
          .timeout(const Duration(seconds: 10));

      if (goldResponse.statusCode != 200) {
        throw Exception('فشل في جلب سعر الذهب');
      }

      final goldData = json.decode(goldResponse.body);
      final pricePerOunceUSD = (goldData['price'] as num?)?.toDouble() ?? 0.0;

      // --- 2️⃣ جلب سعر الدولار مقابل الجنيه ---
      final exchangeResponse = await http
          .get(Uri.parse(exchangeApiUrl))
          .timeout(const Duration(seconds: 10));

      if (exchangeResponse.statusCode != 200) {
        throw Exception('فشل في جلب سعر الدولار مقابل الجنيه');
      }

      final exchangeData = json.decode(exchangeResponse.body);
      final usdToEgp =
          (exchangeData['conversion_rates']?['EGP'] as num?)?.toDouble() ?? 0.0;

      debugPrint('USD → EGP = $usdToEgp');

      // --- 3️⃣ تحويل السعر من أونصة إلى جرام ---
      const ounceToGram = 31.1035;
      final pricePerGramUSD = pricePerOunceUSD / ounceToGram;
      final pricePerGramEGP = pricePerGramUSD * usdToEgp;

      debugPrint('Gold price per gram in EGP: $pricePerGramEGP');

      setState(() {
        goldPricePerGram = pricePerGramEGP;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'حدث خطأ أثناء جلب البيانات. تأكد من اتصالك بالإنترنت.';
      });
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (isLoading) {
      return Scaffold(
        appBar: _buildAppBar(textTheme, theme, localizations),
        body: CustomLoadingIndicator(text: localizations.loading_gold_price),
      );
    }

    if (errorMessage != null ||
        goldPricePerGram == null ||
        goldPricePerGram == 0) {
      return Scaffold(
        appBar: _buildAppBar(textTheme, theme, localizations),
        body: InternetStateManager(
          noInternetScreen: const NoInternetScreen(),
          onRestoreInternetConnection: () {
            fetchGoldPrice();
          },
          child: Center(
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
                    errorMessage ?? localizations.gold_price_error,
                    style: textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: fetchGoldPrice,
                    icon: const Icon(Icons.refresh),
                    label: Text(localizations.retry),
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
        ),
      );
    }

    const nisabGoldGrams = 85;
    final nisabMoney = nisabGoldGrams * goldPricePerGram!;

    return Scaffold(
      appBar: _buildAppBar(textTheme, theme, localizations),
      body: TabBarView(
        controller: _tabController,
        children: [
          MoneyZakatTab(
            nisabMoney: nisabMoney,
            localizations: localizations,
            isArabic: isArabic,
          ),
          GoldZakatTab(
            goldPricePerGram: goldPricePerGram!,
            localizations: localizations,
            isArabic: isArabic,
          ),
          TradeZakatTab(
            nisabMoney: nisabMoney,
            localizations: localizations,
            isArabic: isArabic,
          ),
          CropsZakatTab(localizations: localizations),
        ],
      ),
    );
  }

  AppBar _buildAppBar(
    TextTheme textTheme,
    ThemeData theme,
    AppLocalizations localizations,
  ) => AppBar(
    title: Text(localizations.zakat_calculator),
    actions: [
      IconButton(
        onPressed: fetchGoldPrice,
        icon: const Icon(Icons.refresh),
        tooltip: localizations.refresh_gold_price,
      ),
    ],
    bottom: TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: localizations.money),
        Tab(text: localizations.gold),
        Tab(text: localizations.trade),
        Tab(text: localizations.crops),
      ],
    ),
  );
}

// ==================== Tabs Implementations ====================
class MoneyZakatTab extends StatelessWidget {
  const MoneyZakatTab({
    required this.nisabMoney,
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final double nisabMoney;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => ZakatCard(
    title: localizations.money_zakat_title,
    description: localizations.money_zakat_description(
      isArabic
          ? convertToArabicNumbers(nisabMoney.toStringAsFixed(0))
          : nisabMoney.toStringAsFixed(0),
      isArabic ? convertToArabicNumbers('2.5') : '2.5',
    ),
    hintText: localizations.money_zakat_hint,
    calculate: (input) => (double.tryParse(input) ?? 0) * 0.025,
    localizations: localizations,
  );
}

class GoldZakatTab extends StatelessWidget {
  const GoldZakatTab({
    required this.goldPricePerGram,
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final double goldPricePerGram;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final descriptionText = localizations.gold_zakat_description(
      isArabic
          ? convertToArabicNumbers(goldPricePerGram.toStringAsFixed(2))
          : goldPricePerGram.toStringAsFixed(2),
      isArabic ? convertToArabicNumbers('85') : '85',
      isArabic ? convertToArabicNumbers('2.5') : '2.5',
    );

    return ZakatCard(
      title: localizations.gold_zakat_title,
      description: descriptionText,
      hintText: localizations.gold_zakat_hint,
      calculate: (input) {
        final grams = double.tryParse(input) ?? 0;
        return grams * goldPricePerGram * 0.025;
      },
      localizations: localizations,
    );
  }
}

class TradeZakatTab extends StatelessWidget {
  const TradeZakatTab({
    required this.nisabMoney,
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final double nisabMoney;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => ZakatCard(
    title: localizations.trade_zakat_title,
    description: localizations.trade_zakat_description(
      isArabic
          ? convertToArabicNumbers(nisabMoney.toStringAsFixed(0))
          : nisabMoney.toStringAsFixed(0),
      isArabic ? convertToArabicNumbers('2.5') : '2.5',
    ),
    hintText: localizations.trade_zakat_hint,
    calculate: (input) => (double.tryParse(input) ?? 0) * 0.025,
    localizations: localizations,
  );
}
