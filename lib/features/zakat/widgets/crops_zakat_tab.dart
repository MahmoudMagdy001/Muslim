// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../core/utils/format_helper.dart';

class CropsZakatTab extends StatefulWidget {
  const CropsZakatTab({super.key});

  @override
  State<CropsZakatTab> createState() => _CropsZakatTabState();
}

class _CropsZakatTabState extends State<CropsZakatTab> {
  final TextEditingController _controller = TextEditingController();
  String irrigationType = 'natural';
  double? _result;
  bool _hasError = false;

  void _calculate() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = null;
        _hasError = true;
      });
      return;
    }

    final cropAmount = double.tryParse(input);
    if (cropAmount == null || cropAmount < 0) {
      setState(() {
        _result = null;
        _hasError = true;
      });
      return;
    }

    final rate = irrigationType == 'natural' ? 0.10 : 0.05;
    setState(() {
      _result = cropAmount * rate;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SingleChildScrollView(
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
                        Expanded(
                          child: Text(
                            '🌾 زكاة الزروع والثمار',
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
                      'تجب الزكاة إذا بلغ المحصول ${convertToArabicNumbers('653')} كجم تقريبًا.\n\n'
                      '${convertToArabicNumbers('10')}% إن كانت تُسقى بماء المطر أو الأنهار\n'
                      '${convertToArabicNumbers('5')} % إن كانت بالآلات (مكلفة السقي)',
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
                        labelText: 'أدخل كمية المحصول بالكيلوجرام',
                        errorText: _hasError ? 'الرجاء إدخال قيمة صحيحة' : null,
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
                      onSubmitted: (_) => _calculate(),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        _buildIrrigationOption(
                          'natural',
                          '💧 مطر أو أنهار (${convertToArabicNumbers('10')}%)',
                          'السقي الطبيعي بدون تكاليف',
                          theme,
                        ),
                        const SizedBox(height: 8),
                        _buildIrrigationOption(
                          'machine',
                          '⚙️ آلة أو مكلف (${convertToArabicNumbers('5')}%)',
                          'السقي بالآلات أو بتكاليف',
                          theme,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _calculate,
                        icon: const Icon(Icons.calculate),
                        label: Text(
                          'احسب الزكاة',
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'الزكاة المستحقة:',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            ' ${convertToArabicNumbers(_result!.toStringAsFixed(2))} كجم',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
  ) => RadioListTile<String>(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    ),
    value: value,
    groupValue: irrigationType,
    onChanged: (val) => setState(() => irrigationType = val!),
  );
}
