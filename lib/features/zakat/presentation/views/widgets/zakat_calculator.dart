import 'package:flutter/material.dart';

import 'package:muslim/features/zakat/presentation/views/zakat_view.dart';

@Deprecated('Use ZakatView instead')
class ZakatCalculator extends StatelessWidget {
  const ZakatCalculator({super.key});

  @override
  Widget build(BuildContext context) => const ZakatView();
}
