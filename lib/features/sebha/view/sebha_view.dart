import 'package:flutter/material.dart';

import 'widgets/sebha_button.dart'; // ✅ عشان الهزاز

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  int? customGoal;

  final List<Map<String, dynamic>> azkar = [
    {'text': 'سبحان الله', 'count': 33},
    {'text': 'الحمد لله', 'count': 33},
    {'text': 'الله أكبر', 'count': 34},
    {'text': 'لا إله إلا الله', 'count': 100},
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
        title: const Text('تهانينا 🎉'),
        content: Text(
          'لقد أكملت $maxCount تسبيحة.\nهل تريد إعادة العد من البداية أم تكمل؟',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              reset();
            },
            child: const Text('إعادة من البداية'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('أكمل'),
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
        title: const Text('تحديد الهدف'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'ضع هدفك (مثلاً 50)'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                customGoal = null;
              });
            },
            child: const Text('إزالة الهدف'),
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
            child: const Text('حفظ الهدف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('السبحة الإلكترونية')),
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
                              azkar[index]['text'],
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
                azkar[currentIndex]['text'],
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
                        label: const Text('إعادة التعيين'),
                      ),
                      TextButton.icon(
                        onPressed: _showGoalDialog,
                        icon: const Icon(Icons.flag),
                        label: const Text('الهدف'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
