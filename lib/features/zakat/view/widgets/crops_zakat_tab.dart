// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';

class CropsZakatTab extends StatefulWidget {
  const CropsZakatTab({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  State<CropsZakatTab> createState() => _CropsZakatTabState();
}

class _CropsZakatTabState extends State<CropsZakatTab> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String> irrigationTypeNotifier = ValueNotifier('natural');
  final ValueNotifier<double?> resultNotifier = ValueNotifier(null);
  final ValueNotifier<bool> hasErrorNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _controller.dispose();
    irrigationTypeNotifier.dispose();
    resultNotifier.dispose();
    hasErrorNotifier.dispose();
    super.dispose();
  }

  void _calculate() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      resultNotifier.value = null;
      hasErrorNotifier.value = true;
      return;
    }

    final cropAmount = double.tryParse(input);
    if (cropAmount == null || cropAmount < 0) {
      resultNotifier.value = null;
      hasErrorNotifier.value = true;
      return;
    }

    final rate = irrigationTypeNotifier.value == 'natural' ? 0.10 : 0.05;
    resultNotifier.value = cropAmount * rate;
    hasErrorNotifier.value = false;
  }

  void _clear() {
    _controller.clear();
    resultNotifier.value = null;
    hasErrorNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.localizations.crops_zakat_title,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.toH),
                  Text(
                    widget.localizations.crops_zakat_description(
                      isArabic ? convertToArabicNumbers('10') : '10',
                      isArabic ? convertToArabicNumbers('5') : '5',
                      isArabic ? convertToArabicNumbers('653') : '653',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withAlpha(230),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.toH),

            // Input Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: hasErrorNotifier,
                    builder: (context, hasError, child) => TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        hintText: widget.localizations.crops_zakat_hint,
                        hintStyle: TextStyle(
                          color: theme.hintColor,
                          fontSize: 14.toSp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.toW,
                          vertical: 16.toH,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.toR),
                          borderSide: BorderSide.none,
                        ),
                        errorText: hasError
                            ? widget.localizations.invalid_input_error
                            : null,
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: theme.hintColor),
                                onPressed: _clear,
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        if (hasError) {
                          hasErrorNotifier.value = false;
                        }
                      },
                      onSubmitted: (_) => _calculate(),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  SizedBox(height: 20.toH),

                  // Radio Buttons for Irrigation
                  ValueListenableBuilder<String>(
                    valueListenable: irrigationTypeNotifier,
                    builder: (context, irrigationType, child) => Column(
                      children: [
                        _buildIrrigationOption(
                          'natural',
                          widget.localizations.natural_irrigation_title(
                            isArabic ? convertToArabicNumbers('10') : '10',
                          ),
                          widget.localizations.natural_irrigation_subtitle,
                          theme,
                          irrigationType,
                        ),
                        SizedBox(height: 8.toH),
                        _buildIrrigationOption(
                          'machine',
                          widget.localizations.machine_irrigation_title(
                            isArabic ? convertToArabicNumbers('5') : '5',
                          ),
                          widget.localizations.machine_irrigation_subtitle,
                          theme,
                          irrigationType,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.toH),

                  SizedBox(
                    width: double.infinity,
                    height: 48.toH,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        widget.localizations.calculate_zakat,
                        style: textTheme.titleMedium?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Result Card
            ValueListenableBuilder<double?>(
              valueListenable: resultNotifier,
              builder: (context, result, child) {
                if (result == null) return const SizedBox.shrink();
                return Column(
                  children: [
                    SizedBox(height: 20.toH),
                    Container(
                      padding: EdgeInsets.all(20.toR),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20.toR),
                        border: Border.all(
                          color: theme.primaryColor.withAlpha(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.shadow.withAlpha(10),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.localizations.due_zakat,
                            style: textTheme.titleMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.toH),
                          Text(
                            ' ${isArabic ? convertToArabicNumbers(result.toStringAsFixed(2)) : result.toStringAsFixed(2)} ${widget.localizations.unit_kg}',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIrrigationOption(
    String value,
    String title,
    String subtitle,
    ThemeData theme,
    String currentIrrigationType,
  ) => Theme(
    data: context.theme.copyWith(
      unselectedWidgetColor: context.colorScheme.onPrimary.withAlpha(180),
    ),
    child: RadioListTile<String>(
      activeColor: theme.colorScheme.secondary,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                    fontSize: 16.toSp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12.toSp,
          color: theme.colorScheme.onPrimary.withAlpha(180),
        ),
      ),
      value: value,
      groupValue: currentIrrigationType,
      onChanged: (val) => irrigationTypeNotifier.value = val!,
    ),
  );
}
