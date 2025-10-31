import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'widgets/sebha_button.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  int? customGoal;

  final List<Map<String, dynamic>> azkar = [
    {'textAr': 'سبحان الله', 'textEn': 'Subhan Allah', 'count': 33},
    {'textAr': 'الحمد لله', 'textEn': 'Alhamdulillah', 'count': 33},
    {'textAr': 'الله أكبر', 'textEn': 'Allahu Akbar', 'count': 34},
    {'textAr': 'لا إله إلا الله', 'textEn': 'La ilaha illallah', 'count': 100},
  ];

  int currentIndex = 0;

  int get currentGoal => customGoal ?? azkar[currentIndex]['count'] as int;

  @override
  void initState() {
    super.initState();
    customGoal = azkar[currentIndex]['count'] as int;
  }

  void increment() {
    setState(() {
      counter++;
    });

    if (customGoal != null && counter == currentGoal) {
      Future.delayed(Duration.zero, () {
        _showCompleteDialog(currentGoal);
      });
    }
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  void selectZikr(int index) {
    setState(() {
      currentIndex = index;
      counter = 0;
      customGoal = azkar[index]['count'] as int;
    });
  }

  void _showCompleteDialog(int maxCount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${widget.localizations.congrates} 🎉'),
        content: Text(
          '${widget.localizations.completeTasbeh} $maxCount\n ${widget.localizations.tasbehQuestion}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              reset();
            },
            child: Text(widget.localizations.resetTasbeh),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(widget.localizations.continueTasbeh),
          ),
        ],
      ),
    );
  }

  void _showGoalDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.localizations.chooseGoal),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: widget.localizations.goalExample,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                customGoal = null;
              });
            },
            child: Text(widget.localizations.clear),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final value = int.tryParse(controller.text);
                if (value != null && value > 0) {
                  setState(() {
                    customGoal = value;
                  });
                }
              }
              Navigator.pop(context);
            },
            child: Text(widget.localizations.save),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(widget.localizations.cancelButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.localizations.sebhaTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ الأذكار في كروت
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: azkar.length,
                itemBuilder: (context, index) {
                  final text = widget.isArabic
                      ? azkar[index]['textAr']
                      : azkar[index]['textEn'];

                  final isSelected = currentIndex == index;
                  return GestureDetector(
                    onTap: () => selectZikr(index),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: isSelected ? 2 : 0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Center(
                          child: Text(
                            text,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: isSelected ? theme.primaryColor : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),

            // ✅ اسم الذكر الحالي
            Text(
              widget.isArabic
                  ? azkar[currentIndex]['textAr']
                  : azkar[currentIndex]['textEn'],
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 25),

            // ✅ زرار التسبيح مع Pulse animation
            SebhaButton(
              onPressed: () {
                increment();
              },
              counter: counter,
              goal: customGoal,
              localizations: widget.localizations,
            ),

            const SizedBox(height: 30),

            // ✅ كارت الخيارات
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: reset,
                      icon: const Icon(Icons.restart_alt),
                      label: Text(widget.localizations.resetTasbeh),
                    ),
                    TextButton.icon(
                      onPressed: _showGoalDialog,
                      icon: const Icon(Icons.flag),
                      label: Text(widget.localizations.goal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
