import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../zakat/view/widgets/zakat_calculator.dart';

class ZakatCardWidget extends StatelessWidget {
  const ZakatCardWidget({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(24.toR),
      gradient: LinearGradient(
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
        colors: AppColors.cardGradient(context),
      ),
    ),
    child: InkWell(
      onTap: () => navigateWithTransition(context, const ZakatCalculator()),
      borderRadius: BorderRadius.circular(24.toR),
      child: Padding(
        padding: .symmetric(horizontal: 16.toW, vertical: 16.toH),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    localizations.my_zakat,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                  SizedBox(height: 4.toH),
                  Text(
                    localizations.zakatDuaa,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 16.toH),
                  Container(
                    padding: .symmetric(horizontal: 16.toW, vertical: 8.toH),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20.toR),
                    ),
                    child: Text(
                      localizations.start_calculation,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset('assets/home/img_zakah.png', height: 80.toH),
          ],
        ),
      ),
    ),
  );
}
