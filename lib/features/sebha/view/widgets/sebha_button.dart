import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';

class SebhaButton extends StatefulWidget {
  const SebhaButton({
    required this.onPressed,
    required this.counter,
    required this.localizations,
    super.key,
    this.goal,
  });
  final VoidCallback onPressed;
  final int counter;
  final int? goal;
  final AppLocalizations localizations;

  @override
  State<SebhaButton> createState() => _SebhaButtonState();
}

class _SebhaButtonState extends State<SebhaButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  Future<void> _onTap() async {
    widget.onPressed();
    HapticFeedback.mediumImpact();
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return ScaleTransition(
      scale: _animation,
      child: ElevatedButton(
        onPressed: _onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(
            widget.goal != null ? width * 0.3 : width * 0.37,
          ),
          shape: const CircleBorder(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (widget.goal != null) ...[
              const SizedBox(height: 12),
              Text(
                '${widget.localizations.goal}: ${widget.goal}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
