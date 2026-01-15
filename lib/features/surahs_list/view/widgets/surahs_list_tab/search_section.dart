import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/responsive_helper.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    required this.controller,
    required this.exactSearch,
    required this.onSearchChanged,
    required this.toggleExactSearch,
    required this.clearSearch,
    super.key,
  });

  final TextEditingController controller;
  final bool exactSearch;
  final void Function(String) onSearchChanged;
  final VoidCallback toggleExactSearch;
  final VoidCallback clearSearch;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 8.toH),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'ابحث عن السورة',
          hintStyle: context.textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFC0C0C0),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 8.toW),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 8.toW),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12.toR),
              ),
              child: Image.asset(
                'assets/quran/search.png',
                width: 20.toW,
                color: context.theme.colorScheme.secondary,
              ),
            ),
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) => value.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: context.theme.primaryColor),
                    onPressed: clearSearch,
                  )
                : const SizedBox.shrink(),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.toW,
            vertical: 12.toH,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.toR),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.toR),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.toR),
            borderSide: BorderSide(color: context.theme.primaryColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onSearchChanged,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    ),
  );
}
