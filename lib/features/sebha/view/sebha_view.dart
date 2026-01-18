import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../model/zikr_model.dart';
import '../service/sebha_storage_service.dart';
import 'widgets/custom_zikr_dialog.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/base_app_dialog.dart';
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

class _SebhaViewState extends State<SebhaView> {
  final ValueNotifier<int> counterNotifier = ValueNotifier(0);
  final ValueNotifier<int?> customGoalNotifier = ValueNotifier(null);
  final ValueNotifier<List<ZikrModel>> customAzkarNotifier = ValueNotifier([]);
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  final _storageService = SebhaStorageService();

  final List<ZikrModel> _defaultAzkar = [
    ZikrModel(
      id: 'default_1',
      textAr: 'سبحان الله',
      textEn: 'Subhan Allah',
      count: 33,
    ),
    ZikrModel(
      id: 'default_2',
      textAr: 'الحمد لله',
      textEn: 'Alhamdulillah',
      count: 33,
    ),
    ZikrModel(
      id: 'default_3',
      textAr: 'الله أكبر',
      textEn: 'Allahu Akbar',
      count: 34,
    ),
    ZikrModel(
      id: 'default_4',
      textAr: 'لا إله إلا الله',
      textEn: 'La ilaha illallah',
      count: 100,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomAzkar();
    // Initialize goal with the first zikr's count
    customGoalNotifier.value = _defaultAzkar[0].count;
  }

  @override
  void dispose() {
    counterNotifier.dispose();
    customGoalNotifier.dispose();
    customAzkarNotifier.dispose();
    currentIndexNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadCustomAzkar() async {
    final customAzkar = await _storageService.getCustomAzkar();
    customAzkarNotifier.value = customAzkar;
  }

  void increment() {
    counterNotifier.value++;

    final currentGoal = customGoalNotifier.value;
    if (currentGoal != null && counterNotifier.value == currentGoal) {
      Future.delayed(Duration.zero, () {
        if (mounted) _showCompleteDialog(currentGoal);
      });
    }
  }

  void reset() {
    counterNotifier.value = 0;
  }

  void selectZikr(int index) {
    currentIndexNotifier.value = index;
    counterNotifier.value = 0;

    // Use current updated list logic
    final allAzkar = [..._defaultAzkar, ...customAzkarNotifier.value];
    if (index < allAzkar.length) {
      customGoalNotifier.value = allAzkar[index].count;
    }
  }

  void _showCompleteDialog(int maxCount) {
    BaseAppDialog.show(
      context,
      title: '${widget.localizations.congrates} 🎉',
      contentText:
          '${widget.localizations.completeTasbeh} $maxCount\n ${widget.localizations.tasbehQuestion}',
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
    );
  }

  void _showGoalDialog() {
    final controller = TextEditingController();

    BaseAppDialog.show(
      context,
      title: widget.localizations.chooseGoal,
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
            customGoalNotifier.value = null;
          },
          child: Text(widget.localizations.clear),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                customGoalNotifier.value = value;
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
    );
  }

  Future<void> _showAddCustomZikrDialog() async {
    final result = await showDialog<ZikrModel>(
      context: context,
      builder: (context) =>
          CustomZikrDialog(localizations: widget.localizations),
    );

    if (result != null) {
      final success = await _storageService.saveCustomZikr(result);
      if (success && mounted) {
        await _loadCustomAzkar();
      }
    }
  }

  Future<void> _showEditZikrDialog(ZikrModel zikr) async {
    final result = await showDialog<ZikrModel>(
      context: context,
      builder: (context) =>
          CustomZikrDialog(localizations: widget.localizations, zikr: zikr),
    );

    if (result != null) {
      final success = await _storageService.updateCustomZikr(result);
      if (success && mounted) {
        await _loadCustomAzkar();
        // If the edited zikr was selected, update the goal
        final allAzkar = [..._defaultAzkar, ...customAzkarNotifier.value];
        final currentIndex = currentIndexNotifier.value;
        if (currentIndex < allAzkar.length &&
            allAzkar[currentIndex].id == result.id) {
          customGoalNotifier.value = result.count;
        }
      }
    }
  }

  Future<void> _showDeleteZikrDialog(ZikrModel zikr) async {
    final confirmed = await BaseAppDialog.show<bool>(
      context,
      title: widget.localizations.deleteTasbih,
      contentText: widget.localizations.deleteTasbihConfirm,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(widget.localizations.cancelButton),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: Text(widget.localizations.deleteButton),
        ),
      ],
    );

    if (confirmed == true) {
      final success = await _storageService.deleteCustomZikr(zikr.id);
      if (success && mounted) {
        final allAzkar = [..._defaultAzkar, ...customAzkarNotifier.value];
        final currentIndex = currentIndexNotifier.value;
        // If the deleted zikr was selected, switch to first zikr
        if (currentIndex < allAzkar.length &&
            allAzkar[currentIndex].id == zikr.id) {
          currentIndexNotifier.value = 0;
          counterNotifier.value = 0;
          customGoalNotifier.value = _defaultAzkar[0].count;
        }
        await _loadCustomAzkar();
      }
    }
  }

  void _showZikrOptions(ZikrModel zikr) {
    if (!zikr.isCustom) return; // Only show options for custom zikr

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(widget.localizations.editTasbih),
              onTap: () {
                Navigator.pop(context);
                _showEditZikrDialog(zikr);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: context.colorScheme.error),
              title: Text(
                widget.localizations.deleteTasbih,
                style: TextStyle(color: context.colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteZikrDialog(zikr);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.localizations.sebhaTitle)),
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddCustomZikrDialog,
      child: const Icon(Icons.add),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValueListenableBuilder<List<ZikrModel>>(
              valueListenable: customAzkarNotifier,
              builder: (context, customAzkar, child) {
                final allAzkar = [..._defaultAzkar, ...customAzkar];
                return ValueListenableBuilder<int>(
                  valueListenable: currentIndexNotifier,
                  builder: (context, currentIndex, child) => Column(
                    children: [
                      _AzkarSelector(
                        azkar: allAzkar,
                        currentIndex: currentIndex,
                        isArabic: widget.isArabic,
                        onSelect: selectZikr,
                        onLongPress: _showZikrOptions,
                      ),
                      const SizedBox(height: 40),
                      if (currentIndex < allAzkar.length)
                        Text(
                          widget.isArabic
                              ? allAzkar[currentIndex].textAr
                              : allAzkar[currentIndex].textEn,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder<int>(
              valueListenable: counterNotifier,
              builder: (context, counter, child) =>
                  ValueListenableBuilder<int?>(
                    valueListenable: customGoalNotifier,
                    builder: (context, goal, child) => SebhaButton(
                      onPressed: increment,
                      counter: counter,
                      goal: goal,
                      localizations: widget.localizations,
                    ),
                  ),
            ),
            const SizedBox(height: 30),
            _SebhaControls(
              onReset: reset,
              onSetGoal: _showGoalDialog,
              localizations: widget.localizations,
            ),
          ],
        ),
      ),
    ),
  );
}

class _AzkarSelector extends StatelessWidget {
  const _AzkarSelector({
    required this.azkar,
    required this.currentIndex,
    required this.isArabic,
    required this.onSelect,
    required this.onLongPress,
  });

  final List<ZikrModel> azkar;
  final int currentIndex;
  final bool isArabic;
  final ValueChanged<int> onSelect;
  final ValueChanged<ZikrModel> onLongPress;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 60,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: azkar.length,
      itemBuilder: (context, index) {
        final text = isArabic ? azkar[index].textAr : azkar[index].textEn;
        final isSelected = currentIndex == index;

        return GestureDetector(
          onTap: () => onSelect(index),
          onLongPress: () => onLongPress(azkar[index]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected
                    ? context.colorScheme.secondary
                    : Colors.transparent,
                width: isSelected ? 2 : 0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Center(
                child: Text(
                  text,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: isSelected ? context.colorScheme.secondary : null,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class _SebhaControls extends StatelessWidget {
  const _SebhaControls({
    required this.onReset,
    required this.onSetGoal,
    required this.localizations,
  });

  final VoidCallback onReset;
  final VoidCallback onSetGoal;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt),
            label: Text(localizations.resetTasbeh),
            style: TextButton.styleFrom(
              foregroundColor: context.colorScheme.onSurface,
            ),
          ),
          TextButton.icon(
            onPressed: onSetGoal,
            icon: const Icon(Icons.flag),
            label: Text(localizations.goal),
            style: TextButton.styleFrom(
              foregroundColor: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    ),
  );
}
