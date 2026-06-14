import 'package:flutter/material.dart';

import 'package:muslim/features/qiblah/presentation/views/widgets/compass_widget.dart';

class QiblahSuccessWidget extends StatelessWidget {
  const QiblahSuccessWidget({
    required this.headingAngle,
    required this.qiblahAngle,
    required this.isAligned,
    required this.isLoading,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      children: [
        Expanded(
          child: CompassWidget(
            headingAngle: headingAngle,
            qiblahAngle: qiblahAngle,
            isAligned: isAligned,
            isLoading: isLoading,
          ),
        ),
      ],
    ),
  );
}
