import 'package:flutter/material.dart';

import 'app_info_section.dart';
import 'font_size_section.dart';
import 'rectire_section.dart';
import 'theme_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FontSizeSection(),
        SizedBox(height: 20),
        ThemeSection(),
        SizedBox(height: 20),
        ReciterSection(),
        SizedBox(height: 20),
        AppInfoSection(),
      ],
    ),
  );
}
