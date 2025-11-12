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
      padding: const EdgeInsetsDirectional.only(start: 6, end: 18, top: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'ابحث عن آية أو كلمة في القرآن',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  exactSearch ? Icons.check_box : Icons.check_box_outline_blank,
                  color: exactSearch ? Theme.of(context).primaryColor : null,
                ),
                onPressed: toggleExactSearch,
                tooltip: 'تفعيل البحث الدقيق',
              ),
              if (controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: clearSearch,
                ),
            ],
          ),
        ),
        onChanged: onSearchChanged,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    ),
  );
}
