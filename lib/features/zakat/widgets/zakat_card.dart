import 'package:flutter/material.dart';

import '../../../core/utils/format_helper.dart';
import '../../../l10n/app_localizations.dart';

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
  double? _result;
  bool _hasError = false;

  void _compute() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = null;
        _hasError = true;
      });
      return;
    }

    final value = double.tryParse(input);
    if (value == null || value < 0) {
      setState(() {
        _result = null;
        _hasError = true;
      });
      return;
    }

    setState(() {
      _result = widget.calculate(input);
      _hasError = false;
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _result = null;
      _hasError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          // Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: textTheme.bodyMedium?.copyWith(height: 1.5),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Input Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.hintText,
                      errorText: _hasError
                          ? widget.localizations.invalid_input_error
                          : null,
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _clear,
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      if (_hasError) {
                        setState(() => _hasError = false);
                      }
                    },
                    onSubmitted: (_) => _compute(),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _compute,
                      icon: const Icon(Icons.calculate),
                      label: Text(
                        widget.localizations.calculate_zakat,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Result Card
          if (_result != null) ...[
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.localizations.due_zakat}:',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          ' ${isArabic ? convertToArabicNumbers(_result!.toStringAsFixed(2)) : _result!.toStringAsFixed(2)} ${isArabic ? 'جنيه' : 'EGP'}',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    if (widget.showNisabInfo && _result != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.amber[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.localizations.zakat_reminder,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.amber[700],
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
            ),
          ],
        ],
      ),
    );
  }
}
