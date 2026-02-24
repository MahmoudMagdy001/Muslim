import 'package:flutter_qiblah/flutter_qiblah.dart';

abstract class QiblahLocalDataSource {
  Stream<QiblahDirection> get qiblahStream;
}

class QiblahLocalDataSourceImpl implements QiblahLocalDataSource {
  @override
  Stream<QiblahDirection> get qiblahStream => FlutterQiblah.qiblahStream;
}
