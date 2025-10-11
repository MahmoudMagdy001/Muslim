import 'package:flutter/material.dart';

class QiblahErrorWidget extends StatelessWidget {
  const QiblahErrorWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        message ?? '❌ حدث خطأ غير متوقع',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    ),
  );
}
