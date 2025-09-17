// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/consts/reciters_name_arabic.dart';
import 'provider/font_size_provider.dart';
import 'provider/rectire_provider.dart';
import 'provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      await Provider.of<ReciterProvider>(
        context,
        listen: false,
      ).refreshReciter();
    } catch (e) {
      debugPrint('Error refreshing reciter: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const SettingsContent(),
    ),
  );
}

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

class FontSizeSection extends StatelessWidget {
  const FontSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    final fontSize = fontSizeProvider.fontSize;

    return _SectionCard(
      title: 'حجم الخط',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FontSizeSlider(fontSizeProvider: fontSizeProvider),
          const SizedBox(height: 8),
          _FontSizeIndicator(fontSize: fontSize),
        ],
      ),
    );
  }
}

class _FontSizeSlider extends StatelessWidget {
  const _FontSizeSlider({required this.fontSizeProvider});
  final FontSizeProvider fontSizeProvider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontSize = fontSizeProvider.fontSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('أصغر', style: theme.textTheme.bodyMedium),
        Expanded(
          child: Slider(
            value: fontSize,
            min: 12.0,
            max: 23.0,
            divisions: 11,
            label: fontSize.round().toString(),
            onChanged: (value) => fontSizeProvider.setFontSize(value),
          ),
        ),
        Text('أكبر', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

class _FontSizeIndicator extends StatelessWidget {
  const _FontSizeIndicator({required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.primaryColor.withAlpha(25),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryColor.withAlpha(76)),
        ),
        child: Text(
          'الحجم: ${fontSize.round()}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return _SectionCard(
      title: 'المظهر',
      child: _ThemeSwitch(themeProvider: themeProvider, isDarkMode: isDarkMode),
    );
  }
}

class _ThemeSwitch extends StatelessWidget {
  const _ThemeSwitch({required this.themeProvider, required this.isDarkMode});
  final ThemeProvider themeProvider;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, size: 28),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isDarkMode ? 'الوضع الليلي' : 'الوضع النهاري',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            isDarkMode
                ? 'التبديل إلى الوضع النهاري'
                : 'التبديل إلى الوضع الليلي',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (_) => themeProvider.toggleTheme(),
      ),
      onTap: themeProvider.toggleTheme,
    );
  }
}

class ReciterSection extends StatelessWidget {
  const ReciterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final reciterProvider = Provider.of<ReciterProvider>(context);
    final selectedReciterId = reciterProvider.selectedReciter;
    final reciterName = getReciterName(selectedReciterId);

    return _SectionCard(
      title: 'اختيار القارئ',
      child: _ReciterTile(
        reciterProvider: reciterProvider,
        reciterName: reciterName,
      ),
    );
  }
}

class _ReciterTile extends StatelessWidget {
  const _ReciterTile({
    required this.reciterProvider,
    required this.reciterName,
  });
  final ReciterProvider reciterProvider;
  final String reciterName;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(25),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.headphones, size: 20),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reciterName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'تغيير قارئ القرآن الكريم',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () => _showReciterDialog(context, reciterProvider),
  );

  Future<void> _showReciterDialog(
    BuildContext context,
    ReciterProvider reciterProvider,
  ) async {
    final String selectedReciterId = reciterProvider.selectedReciter;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => ReciterDialog(selectedReciterId: selectedReciterId),
    );

    if (result != null && result != reciterProvider.selectedReciter) {
      await reciterProvider.saveReciter(result);
    }
  }
}

class ReciterDialog extends StatefulWidget {
  const ReciterDialog({required this.selectedReciterId, super.key});
  final String selectedReciterId;

  @override
  State<ReciterDialog> createState() => _ReciterDialogState();
}

class _ReciterDialogState extends State<ReciterDialog> {
  late String _selectedReciterId;

  @override
  void initState() {
    super.initState();
    _selectedReciterId = widget.selectedReciterId;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('اختر القارئ', style: theme.textTheme.titleLarge),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: recitersArabic.length,
            itemBuilder: (context, index) => _ReciterRadioItem(
              reciter: recitersArabic[index],
              selectedReciterId: _selectedReciterId,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedReciterId = value);
                }
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _selectedReciterId),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _ReciterRadioItem extends StatelessWidget {
  const _ReciterRadioItem({
    required this.reciter,
    required this.selectedReciterId,
    required this.onChanged,
  });
  final dynamic reciter;
  final String selectedReciterId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = reciter.id == selectedReciterId;

    return RadioListTile<String>(
      title: Text(
        reciter.name,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.primaryColor : null,
        ),
      ),
      value: reciter.id,
      groupValue: selectedReciterId,
      onChanged: onChanged,
    );
  }
}

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) => _SectionCard(
    title: 'معلومات التطبيق',
    child: Column(
      children: [
        const _AppInfoTile(
          icon: Icons.info_outline,
          title: 'إصدار التطبيق',
          subtitle: 'الإصدار 1.0.0',
        ),
        const Divider(),
        _AppInfoTile(
          icon: Icons.privacy_tip_outlined,
          title: 'سياسة الخصوصية',
          onTap: () {},
        ),
      ],
    ),
  );
}

class _AppInfoTile extends StatelessWidget {
  const _AppInfoTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.iconTheme.color),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle!, style: theme.textTheme.bodySmall),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
