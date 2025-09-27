// import 'dart:io';

// import 'package:flutter/material.dart';

// /// Fallback app in case of initialization failure
// class ErrorApp extends StatelessWidget {
//   const ErrorApp({super.key});

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 64, color: Colors.red),
//             const SizedBox(height: 16),
//             const Text(
//               'حدث خطأ في تهيئة التطبيق',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text('يرجى إعادة فتح التطبيق'),
//             const SizedBox(height: 24),
//             ElevatedButton(onPressed: () => exit(0), child: const Text('خروج')),
//           ],
//         ),
//       ),
//     ),
//   );
// }
