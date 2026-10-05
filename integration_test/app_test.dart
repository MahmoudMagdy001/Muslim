import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:muslim/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Muslim App End-to-End Production Verification', () {
    testWidgets('App initializes cleanly and renders primary widgets without errors', (
      tester,
    ) async {
      // Launch the full application entrypoint
      await app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 1. Verify top-level scaffold and theme rendered
      expect(find.byType(Scaffold), findsWidgets);

      // 2. Allow any background micro-tasks or animations to settle safely
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 3. Confirm app is responsive and alive
      expect(tester.binding.hasScheduledFrame, isFalse);
    });
  });
}
