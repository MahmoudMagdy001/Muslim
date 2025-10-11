import 'package:flutter/material.dart';

import 'widgets/settings_content.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الإعدادات')),
    body: const SettingsContent(),
  );
}
