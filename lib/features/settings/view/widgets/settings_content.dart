import 'package:flutter/material.dart';

import 'app_info_section.dart';
import 'font_size_section.dart';
import 'rectire_section.dart';
import 'theme_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(thickness: 0.05);
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FontSizeSection(),
          divider,
          ThemeSection(),
          divider,
          ReciterSection(),
          divider,
          AppInfoSection(),
        ],
      ),
    );
  }
}
