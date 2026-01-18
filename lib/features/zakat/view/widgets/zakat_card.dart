import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';

class ZakatCard extends StatefulWidget {
  const ZakatCard({
    required this.title,
    required this.description,
    required this.hintText,
    required this.calculate,
    required this.localizations,
    this.showNisabInfo = true,
    super.key,
  });

  final String title;
  final String description;
  final String hintText;
  final double Function(String input) calculate;
  final AppLocalizations localizations;

  final bool showNisabInfo;

  @override
  State<ZakatCard> createState() => _ZakatCardState();
}

class _ZakatCardState extends State<ZakatCard> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<double?> resultNotifier = ValueNotifier(null);
  final ValueNotifier<bool> hasErrorNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _controller.dispose();
    resultNotifier.dispose();
    hasErrorNotifier.dispose();
    super.dispose();
  }

  void _compute() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      resultNotifier.value = null;
      hasErrorNotifier.value = true;
      return;
    }

    final value = double.tryParse(input);
    if (value == null || value < 0) {
      resultNotifier.value = null;
      hasErrorNotifier.value = true;
      return;
    }

    resultNotifier.value = widget.calculate(input);
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

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.toR),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(20.toR),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.toH),
                  Text(
                    widget.description,
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
              padding: EdgeInsets.all(20.toR),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(20.toR),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: hasErrorNotifier,
                    builder: (context, hasError, child) => TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        hintText: widget.hintText,
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
                      onSubmitted: (_) => _compute(),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  SizedBox(height: 24.toH),
                  SizedBox(
                    width: double.infinity,
                    height: 48.toH,
                    child: ElevatedButton(
                      onPressed: _compute,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.toR),
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
                            '${isArabic ? convertToArabicNumbers(result.toStringAsFixed(2)) : result.toStringAsFixed(2)} ${isArabic ? 'جنيه' : 'EGP'}',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          if (widget.showNisabInfo) ...[
                            SizedBox(height: 16.toH),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.toW,
                                vertical: 10.toH,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.tertiaryContainer
                                    .withAlpha(
                                      200,
                                    ), // Use tertiary container or similar
                                borderRadius: BorderRadius.circular(12.toR),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: context
                                        .colorScheme
                                        .onTertiaryContainer, // Use meaningful color
                                    size: 20.toR,
                                  ),
                                  SizedBox(width: 8.toW),
                                  Expanded(
                                    child: Text(
                                      widget.localizations.zakat_reminder,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: context
                                            .colorScheme
                                            .onTertiaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
}
