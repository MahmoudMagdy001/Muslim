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
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;

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

    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller4 = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(1, 0), // من اليمين
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeOut));

    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(-1, 0), // من اليسار
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeOut));

    _slideAnimation3 = Tween<Offset>(
      begin: const Offset(0, 1), // من الأسفل للفوق
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOut));

    _slideAnimation4 = Tween<Offset>(
      begin: const Offset(0, 1), // من الأسفل للفوق
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller4, curve: Curves.easeOut));

    _opacityAnimation1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeOut));

    _opacityAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeOut));

    _opacityAnimation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOut));

    _opacityAnimation4 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller4, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // يبدأ الأول
      _controller1.forward().then((_) {
        // بعد انتهاء الأول، يبدأ الثاني
        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          _controller2.forward().then((_) {
            // بعد انتهاء الثاني، يبدأ الثالث
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              _controller3.forward().then((_) {
                // بعد انتهاء الثالث، يبدأ الرابع
                Future.delayed(const Duration(milliseconds: 100)).then((_) {
                  _controller4.forward();
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: SlideTransition(
          position: _slideAnimation1,
          child: FadeTransition(
            opacity: _opacityAnimation1,
            child: PrayerTimesView(
              scaffoldContext: widget.scaffoldContext,
              theme: widget.theme,
              localizations: widget.localizations,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SlideTransition(
          position: _slideAnimation2,
          child: FadeTransition(
            opacity: _opacityAnimation2,
            child: DashboardGrid(
              theme: widget.theme,
              localizations: widget.localizations,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SlideTransition(
          position: _slideAnimation3,
          child: FadeTransition(
            opacity: _opacityAnimation3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  FeatureCard(
                    label: widget.localizations.namesOfAllah,
                    image: 'assets/images/allah.png',
                    onTap: () => navigateWithTransition(
                      context,
                      const NamesOfAllahScreen(),
                    ),
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
        ),
      ),
      SliverToBoxAdapter(
        child: SlideTransition(
          position: _slideAnimation4,
          child: FadeTransition(
            opacity: _opacityAnimation4,
            child: ZakatCardWidget(
              theme: widget.theme,
              localizations: widget.localizations,
            ),
          ),
        ),
      ),
    ],
  );
}
