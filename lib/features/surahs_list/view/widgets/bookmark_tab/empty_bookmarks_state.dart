import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_helper.dart';

class EmptyBookmarksState extends StatefulWidget {
  const EmptyBookmarksState({required this.message, super.key});

  final String message;

  @override
  State<EmptyBookmarksState> createState() => _EmptyBookmarksStateState();
}

class _EmptyBookmarksStateState extends State<EmptyBookmarksState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              padding: EdgeInsets.all(20.toR),
              decoration: BoxDecoration(
                color: theme.primaryColor.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 80.toR,
                color: theme.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 32.toH),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.toW),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(180),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
