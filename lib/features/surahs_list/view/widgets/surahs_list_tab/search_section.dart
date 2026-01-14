import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'ابحث عن السورة',
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: const Color(0xFFC0C0C0)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF3F345F),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/quran/search.png',
                width: 20,
                height: 20,
                color: const Color(0xFFDFFF5E),
              ),
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Color(0xFF6751B0)),
                  onPressed: clearSearch,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF6751B0), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF6751B0), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF6751B0), width: 2),
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
