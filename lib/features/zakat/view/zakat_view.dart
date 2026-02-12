import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/custom_loading_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/format_helper.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodels/zakat_cubit.dart';
import '../viewmodels/zakat_state.dart';
import 'widgets/crops_zakat_tab.dart';
import 'widgets/zakat_card.dart';
import 'widgets/zakat_error_view.dart';

class ZakatView extends StatelessWidget {
  const ZakatView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => ZakatCubit(),
    child: const _ZakatViewBody(),
  );
}

class _ZakatViewBody extends StatefulWidget {
  const _ZakatViewBody();

  @override
  State<_ZakatViewBody> createState() => _ZakatViewBodyState();
}

class _ZakatViewBodyState extends State<_ZakatViewBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<ZakatCubit, ZakatState>(
      builder: (context, state) {
        if (state.status == ZakatRequestStatus.loading) {
          return Scaffold(
            appBar: _buildAppBar(textTheme, theme, localizations, context),
            body: CustomLoadingIndicator(
              text: localizations.loading_gold_price,
            ),
          );
        }

        if (state.status == ZakatRequestStatus.error) {
          return Scaffold(
            appBar: _buildAppBar(textTheme, theme, localizations, context),
            body: ZakatErrorView(
              errorMessage: state.errorMessage,
              onRetry: () => _showManualPriceDialog(context, localizations),
              onManualEntry: () =>
                  _showManualPriceDialog(context, localizations),
              localizations: localizations,
            ),
          );
        }

        final goldPricePerGram = state.goldPricePerGram;
        final nisabMoney = state.nisabInEgp;

        if (goldPricePerGram == 0) {
          return Scaffold(
            appBar: _buildAppBar(textTheme, theme, localizations, context),
            body: _GoldPriceInputView(
              localizations: localizations,
              onConfirm: (price) =>
                  context.read<ZakatCubit>().setManualGoldPrice(price),
            ),
          );
        }

        return Scaffold(
          appBar: _buildAppBar(textTheme, theme, localizations, context),
          body: TabBarView(
            controller: _tabController,
            children: [
              MoneyZakatTab(
                nisabMoney: nisabMoney,
                localizations: localizations,
                isArabic: isArabic,
              ),
              GoldZakatTab(
                goldPricePerGram: goldPricePerGram,
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
      },
    );
  }

  AppBar _buildAppBar(
    TextTheme textTheme,
    ThemeData theme,
    AppLocalizations localizations,
    BuildContext context,
  ) => AppBar(
    title: Text(localizations.my_zakat),
    actions: [
      IconButton(
        onPressed: () => _showManualPriceDialog(context, localizations),
        icon: const Icon(Icons.edit),
        tooltip: localizations.enterGoldPriceManually,
      ),
    ],
    bottom: TabBar(
      controller: _tabController,
      labelColor: context.theme.colorScheme.secondary,
      unselectedLabelColor: Colors.white,
      tabs: [
        Tab(text: localizations.money),
        Tab(text: localizations.gold),
        Tab(text: localizations.trade),
        Tab(text: localizations.crops),
      ],
    ),
  );

  Future<void> _showManualPriceDialog(
    BuildContext context,
    AppLocalizations localizations,
  ) async {
    final controller = TextEditingController();
    final cubit = context
        .read<ZakatCubit>(); // Capture Cubit here using parent context
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // Rename inner context to avoid confusion
        title: Text(localizations.enterGoldPriceManually),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localizations.goldPricePerGram,
            hintText: 'e.g. 3500',
            suffixText: 'EGP',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(localizations.cancel),
          ),
          FilledButton(
            onPressed: () {
              final price = double.tryParse(controller.text);
              if (price != null && price > 0) {
                Navigator.pop(dialogContext);
                cubit.setManualGoldPrice(price); // Use captured cubit
              }
            },
            child: Text(localizations.confirm),
          ),
        ],
      ),
    );
    controller.dispose();
  }
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

class _ManualPriceDialog extends StatefulWidget {
  const _ManualPriceDialog({
    required this.localizations,
    required this.onConfirm,
  });

  final AppLocalizations localizations;
  final ValueChanged<double> onConfirm;

  @override
  State<_ManualPriceDialog> createState() => _ManualPriceDialogState();
}

class _ManualPriceDialogState extends State<_ManualPriceDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.localizations.enterGoldPriceManually),
    content: TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        labelText: widget.localizations.goldPricePerGram,
        hintText: 'e.g. 3500',
        suffixText: 'EGP',
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(widget.localizations.cancel),
      ),
      FilledButton(
        onPressed: () {
          final price = double.tryParse(_controller.text);
          if (price != null && price > 0) {
            Navigator.pop(context);
            widget.onConfirm(price);
          }
        },
        child: Text(widget.localizations.confirm),
      ),
    ],
  );
}

class _GoldPriceInputView extends StatefulWidget {
  const _GoldPriceInputView({
    required this.localizations,
    required this.onConfirm,
  });

  final AppLocalizations localizations;
  final ValueChanged<double> onConfirm;

  @override
  State<_GoldPriceInputView> createState() => _GoldPriceInputViewState();
}

class _GoldPriceInputViewState extends State<_GoldPriceInputView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(24.toR),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.monetization_on_outlined,
            size: 80.toSp,
            color: context.theme.colorScheme.primary,
          ),
          SizedBox(height: 24.toH),
          Text(
            widget.localizations.enterGoldPriceManually,
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 32.toH),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium,
            decoration: InputDecoration(
              labelText: widget.localizations.goldPricePerGram,
              hintText: 'e.g. 3500',
              suffixText: 'EGP',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.toR),
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.toW,
                vertical: 16.toH,
              ),
            ),
            onSubmitted: (_) => _submit(),
          ),
          SizedBox(height: 24.toH),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.toH),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.toR),
                ),
              ),
              child: Text(
                widget.localizations.confirm,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void _submit() {
    final price = double.tryParse(_controller.text);
    if (price != null && price > 0) {
      widget.onConfirm(price);
    }
  }
}
