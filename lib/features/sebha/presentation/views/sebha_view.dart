import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';
import 'package:muslim/features/sebha/presentation/cubit/sebha_cubit.dart';
import 'package:muslim/features/sebha/presentation/cubit/sebha_state.dart';
import 'package:muslim/features/sebha/presentation/views/widgets/azkar_selector.dart';
import 'package:muslim/features/sebha/presentation/views/widgets/custom_zikr_dialog.dart';
import 'package:muslim/features/sebha/presentation/views/widgets/sebha_button.dart';
import 'package:muslim/features/sebha/presentation/views/widgets/sebha_controls.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showSebhaTour(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = getIt<SebhaCubit>();
      unawaited(cubit.loadCustomAzkar());
      return cubit;
    },
    child: Builder(
      builder: (context) {
        final l10n = context.l10n;
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';
        final isDark = context.theme.brightness == Brightness.dark;

        return BlocListener<SebhaCubit, SebhaState>(
      listenWhen: (previous, current) =>
          current.goalReached && !previous.goalReached,
      listener: (context, state) {
        _showCompleteDialog(context, state.customGoal ?? 0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.sebhaTitle),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => unawaited(
                AppTourHelper.showSebhaTour(context, force: true),
              ),
              icon: const Icon(Icons.explore_outlined),
              tooltip: l10n.tourSebhaTitle,
            ),
            IconButton(
              key: AppTourKeys.sebhaAddKey,
              onPressed: () => _showAddCustomZikrDialog(context),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),

        body: SafeArea(
          child: Column(
            children: [
              // Azkar selector at the top
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: BlocSelector<SebhaCubit, SebhaState, _AzkarSelectorData>(
                  selector: (state) => _AzkarSelectorData(
                    allAzkar: state.allAzkar,
                    currentIndex: state.currentIndex,
                  ),
                  builder: (context, data) => Column(
                    children: [
                      AzkarSelector(
                        azkar: data.allAzkar,
                        currentIndex: data.currentIndex,
                        isArabic: isArabic,
                        onSelect: context.read<SebhaCubit>().selectZikr,
                        onLongPress: (zikr) =>
                            _showZikrOptions(context, zikr),
                      ),
                      const SizedBox(height: 24),
                      // Current zikr text with animated transitions
                      if (data.currentIndex < data.allAzkar.length)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.15),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                          child: Text(
                            isArabic
                                ? data.allAzkar[data.currentIndex].textAr
                                : data.allAzkar[data.currentIndex].textEn,
                            key: ValueKey(data.allAzkar[data.currentIndex].id),
                            textAlign: TextAlign.center,
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : context.colorScheme.primary,
                              letterSpacing: isArabic ? 0 : 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Center: Button takes the remaining space
              Expanded(
                child: Center(
                  child: BlocSelector<SebhaCubit, SebhaState, _CounterData>(
                    selector: (state) => _CounterData(
                      counter: state.counter,
                      goal: state.customGoal,
                    ),
                    builder: (context, data) => SebhaButton(
                      key: AppTourKeys.sebhaButtonKey,
                      onPressed: context.read<SebhaCubit>().increment,
                      counter: data.counter,
                      goal: data.goal,
                    ),
                  ),
                ),
              ),

              // Controls at the bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SebhaControls(
                  onReset: context.read<SebhaCubit>().reset,
                  onSetGoal: () => _showGoalDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);

  void _showCompleteDialog(BuildContext context, int maxCount) {
    final l10n = context.l10n;

    unawaited(
      BaseAppDialog.show<void>(
        context,
        title: '${l10n.congrates} 🎉',
        contentText: '${l10n.completeTasbeh} $maxCount\n ${l10n.tasbehQuestion}',
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SebhaCubit>().reset();
            },
            child: Text(l10n.resetTasbeh),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.continueTasbeh),
          ),
        ],
      ),
    );
  }

  void _showGoalDialog(BuildContext context) {
    final l10n = context.l10n;
    final controller = TextEditingController();

    unawaited(
      BaseAppDialog.show<void>(
        context,
        title: l10n.chooseGoal,
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: l10n.goalExample),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SebhaCubit>().setGoal(null);
            },
            child: Text(l10n.clear),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final value = int.tryParse(controller.text);
                if (value != null && value > 0) {
                  context.read<SebhaCubit>().setGoal(value);
                }
              }
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelButton),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddCustomZikrDialog(BuildContext context) async {
    final result = await showDialog<ZikrEntity>(
      context: context,
      builder: (context) => const CustomZikrDialog(),
    );

    if (result != null && context.mounted) {
      await context.read<SebhaCubit>().addCustomZikr(result);
    }
  }

  Future<void> _showEditZikrDialog(
    BuildContext context,
    ZikrEntity zikr,
  ) async {
    final result = await showDialog<ZikrEntity>(
      context: context,
      builder: (context) => CustomZikrDialog(zikr: zikr),
    );

    if (result != null && context.mounted) {
      await context.read<SebhaCubit>().editCustomZikr(result);
    }
  }

  Future<void> _showDeleteZikrDialog(
    BuildContext context,
    ZikrEntity zikr,
  ) async {
    final l10n = context.l10n;

    final confirmed = await BaseAppDialog.show<bool>(
      context,
      title: l10n.deleteTasbih,
      contentText: l10n.deleteTasbihConfirm,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancelButton),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: Text(l10n.deleteButton),
        ),
      ],
    );

    if ((confirmed ?? false) && context.mounted) {
      await context.read<SebhaCubit>().deleteCustomZikr(zikr.id);
    }
  }

  void _showZikrOptions(BuildContext context, ZikrEntity zikr) {
    if (!zikr.isCustom) return;

    final l10n = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: isDark ? context.colorScheme.surface : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (bottomSheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withAlpha(40)
                        : Colors.black.withAlpha(25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit_rounded,
                    color: isDark ? Colors.white70 : context.colorScheme.primary,
                  ),
                  title: Text(l10n.editTasbih),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    unawaited(_showEditZikrDialog(context, zikr));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_rounded,
                    color: context.colorScheme.error,
                  ),
                  title: Text(
                    l10n.deleteTasbih,
                    style: TextStyle(color: context.colorScheme.error),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    unawaited(_showDeleteZikrDialog(context, zikr));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Data class for BlocSelector to minimize rebuilds on the azkar selector.
class _AzkarSelectorData extends Equatable {
  const _AzkarSelectorData({
    required this.allAzkar,
    required this.currentIndex,
  });

  final List<ZikrEntity> allAzkar;
  final int currentIndex;

  @override
  List<Object?> get props => [allAzkar, currentIndex];
}

/// Data class for BlocSelector to minimize rebuilds on the counter button.
class _CounterData extends Equatable {
  const _CounterData({required this.counter, required this.goal});

  final int counter;
  final int? goal;

  @override
  List<Object?> get props => [counter, goal];
}
