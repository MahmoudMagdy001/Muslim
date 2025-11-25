import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import '../../../sebha/view/sebha_view.dart';
import 'dashboard_list.dart';
import 'feature_card.dart';
import 'zakat_card_widget.dart';

class LayoutContent extends StatefulWidget {
  const LayoutContent(
    this.scaffoldContext,
    this.theme, {
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final BuildContext scaffoldContext;
  final ThemeData theme;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  State<LayoutContent> createState() => _LayoutContentState();
}

class _LayoutContentState extends State<LayoutContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;
  late Animation<Offset> _slideAnimation3;
  late Animation<Offset> _slideAnimation4;

  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;
  late Animation<double> _opacityAnimation4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2700),
      vsync: this,
    );

    // Animation 1: 0ms - 600ms (0.0 - 0.222)
    const interval1 = Interval(0.0, 0.222, curve: Curves.easeOut);
    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(1, 0), // From right
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: interval1));

    _opacityAnimation1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: interval1));

    // Animation 2: 700ms - 1300ms (0.259 - 0.481)
    const interval2 = Interval(0.259, 0.481, curve: Curves.easeOut);
    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(-1, 0), // From left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: interval2));

    _opacityAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: interval2));

    // Animation 3: 1400ms - 2000ms (0.518 - 0.740)
    const interval3 = Interval(0.518, 0.740, curve: Curves.easeOut);
    _slideAnimation3 = Tween<Offset>(
      begin: const Offset(0, 1), // From bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: interval3));

    _opacityAnimation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: interval3));

    // Animation 4: 2100ms - 2700ms (0.777 - 1.0)
    const interval4 = Interval(0.777, 1.0, curve: Curves.easeOut);
    _slideAnimation4 = Tween<Offset>(
      begin: const Offset(0, 1), // From bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: interval4));

    _opacityAnimation4 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: interval4));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedSliver({
    required Animation<Offset> offsetAnimation,
    required Animation<double> opacityAnimation,
    required Widget child,
  }) => SliverToBoxAdapter(
    child: SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: opacityAnimation, child: child),
    ),
  );

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      _buildAnimatedSliver(
        offsetAnimation: _slideAnimation1,
        opacityAnimation: _opacityAnimation1,
        child: PrayerTimesView(
          scaffoldContext: widget.scaffoldContext,
          theme: widget.theme,
          localizations: widget.localizations,
        ),
      ),
      _buildAnimatedSliver(
        offsetAnimation: _slideAnimation2,
        opacityAnimation: _opacityAnimation2,
        child: DashboardGrid(
          theme: widget.theme,
          localizations: widget.localizations,
        ),
      ),
      _buildAnimatedSliver(
        offsetAnimation: _slideAnimation3,
        opacityAnimation: _opacityAnimation3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              FeatureCard(
                label: widget.localizations.namesOfAllah,
                image: 'assets/images/allah.png',
                onTap: () =>
                    navigateWithTransition(context, const NamesOfAllahScreen()),
                theme: widget.theme,
              ),
              FeatureCard(
                label: widget.localizations.sebha,
                image: 'assets/images/seb7a.png',
                onTap: () => navigateWithTransition(
                  context,
                  SebhaView(
                    localizations: widget.localizations,
                    isArabic: widget.isArabic,
                  ),
                ),
                theme: widget.theme,
              ),
            ],
          ),
        ),
      ),
      _buildAnimatedSliver(
        offsetAnimation: _slideAnimation4,
        opacityAnimation: _opacityAnimation4,
        child: ZakatCardWidget(
          theme: widget.theme,
          localizations: widget.localizations,
        ),
      ),
    ],
  );
}
