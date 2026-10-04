import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/zakat/presentation/views/zakat_view.dart';
import 'package:muslim/l10n/app_localizations.dart';

class ZakatCardWidget extends StatelessWidget {
  const ZakatCardWidget({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: .circular(24.toR),
      gradient: LinearGradient(
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
        colors: context.cardGradient,
      ),
    ),
    child: InkWell(
      onTap: () => unawaited(navigateWithTransition<void>(context, const ZakatView())),
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
