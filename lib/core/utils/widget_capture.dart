import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Native widget-to-PNG-bytes capture — replaces the `screenshot` package.
///
/// Usage (off-screen widget, like [ScreenshotController.captureFromWidget]):
/// ```dart
/// final bytes = await WidgetCapture.captureFromWidget(
///   MyWidget(),
///   pixelRatio: 2.0,
/// );
/// ```
///
/// Usage (on-screen widget via [GlobalKey]):
/// ```dart
/// final key = GlobalKey();
/// // … attach key to a widget …
/// final bytes = await WidgetCapture.captureFromKey(key);
/// ```
abstract final class WidgetCapture {
  /// Renders [widget] off-screen and returns PNG bytes.
  ///
  /// [pixelRatio] controls output resolution (default 3.0 for high-DPI).
  /// [delay] gives async widgets (e.g. images) time to settle before capture.
  /// [context] is optional — if provided, inherits [Theme] and [MediaQuery].
  static Future<List<int>> captureFromWidget(
    Widget widget, {
    double pixelRatio = 3.0,
    Duration delay = const Duration(milliseconds: 20),
    BuildContext? context,
    Size logicalSize = const Size(1080, 1400),
  }) async {
    // ignore: omit_local_variable_types
    Widget child = widget;

    if (context != null) {
      child = Theme(
        data: Theme.of(context),
        child: MediaQuery(
          data: MediaQuery.of(context),
          child: child,
        ),
      );
    }

    final repaintBoundary = RenderRepaintBoundary();
    final renderView = RenderView(
      view: ui.PlatformDispatcher.instance.views.first,
      child: RenderPositionedBox(
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(logicalSize),
        devicePixelRatio: pixelRatio,
      ),
    );

    final pipelineOwner = PipelineOwner()..rootNode = renderView;
    renderView.prepareInitialFrame();

    final buildOwner = BuildOwner(focusManager: FocusManager());
    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: child,
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner
      ..buildScope(rootElement)
      ..finalizeTree();

    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();

    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
      buildOwner
        ..buildScope(rootElement)
        ..finalizeTree();
      pipelineOwner
        ..flushLayout()
        ..flushCompositingBits()
        ..flushPaint();
    }

    final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();

    return byteData!.buffer.asUint8List();
  }

  /// Captures an on-screen widget attached to [key] and returns PNG bytes.
  static Future<List<int>> captureFromKey(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) throw StateError('No RenderRepaintBoundary found for key');
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData!.buffer.asUint8List();
  }
}
