import 'dart:io';

void main() {
  print('🧱 MVVM + Cubit + Repository + Service Structure Generator for Flutter');

  // === 1. إدخال اسم الفيتشر ===
  stdout.write('📦 Enter feature name (e.g. auth, home): ');
  final rawFeature = stdin.readLineSync();
  final feature = rawFeature?.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');

  if (feature == null || feature.isEmpty) {
    print('❌ Feature name is required.');
    return;
  }

  final basePath = 'lib/features/$feature';

  // === 2. إنشاء المجلدات ===
  final directories = [
    '$basePath/model',
    '$basePath/view',
    '$basePath/viewmodel',
    '$basePath/repository',
    '$basePath/service',
  ];

  for (final dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('✅ Created: $dir');
    }
  }

  // === 3. إنشاء الملفات ===
  final className = _capitalize(feature);
  final modelFile = File('$basePath/model/${feature}_model.dart');
  final stateFile = File('$basePath/viewmodel/${feature}_state.dart');
  final cubitFile = File('$basePath/viewmodel/${feature}_cubit.dart');
  final viewFile = File('$basePath/view/${feature}_view.dart');
  final repoFile = File('$basePath/repository/${feature}_repository.dart');
  final repoImplFile = File('$basePath/repository/${feature}_repository_impl.dart');
  final serviceFile = File('$basePath/service/${feature}_service.dart');

  _writeFileIfNotExists(modelFile, '''
class ${className}Model {
  // TODO: Define your model
}
''');

  _writeFileIfNotExists(stateFile, '''
enum ${className}Status { initial, loading, success, error }

class ${className}State {
  final ${className}Status status;
  final String? message;

  const ${className}State({
    this.status = ${className}Status.initial,
    this.message,
  });

  ${className}State copyWith({
    ${className}Status? status,
    String? message,
  }) {
    return ${className}State(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
''');

  _writeFileIfNotExists(serviceFile, '''
class ${className}Service {
  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception("Simulated service error");
  }
}
''');

  _writeFileIfNotExists(repoFile, '''
abstract class ${className}Repository {
  Future<void> fetchData();
}
''');

  _writeFileIfNotExists(repoImplFile, '''
import '${feature}_repository.dart';
import '../service/${feature}_service.dart';

class ${className}RepositoryImpl implements ${className}Repository {
  final ${className}Service service;

  ${className}RepositoryImpl(this.service);

  @override
  Future<void> fetchData() {
    return service.fetchData();
  }
}
''');

  _writeFileIfNotExists(cubitFile, '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${feature}_state.dart';
import '../repository/${feature}_repository.dart';
import '../repository/${feature}_repository_impl.dart';

class ${className}Cubit extends Cubit<${className}State> {
  final ${className}Repository repository;

  ${className}Cubit(this.repository) : super(const ${className}State());

  Future<void> example() async {
    emit(state.copyWith(status: ${className}Status.loading));
    try {
      await repository.fetchData();
      emit(state.copyWith(status: ${className}Status.success));
    } catch (e) {
      emit(state.copyWith(
        status: ${className}Status.error,
        message: e.toString(),
      ));
    }
  }
}
''');

  _writeFileIfNotExists(viewFile, '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/${feature}_cubit.dart';
import '../viewmodel/${feature}_state.dart';
import '../repository/${feature}_repository_impl.dart';
import '../service/${feature}_service.dart';

class ${className}View extends StatelessWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ${className}Cubit(
        ${className}RepositoryImpl(${className}Service()),
      ),
      child: BlocBuilder<${className}Cubit, ${className}State>(
        builder: (context, state) {
          if (state.status == ${className}Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ${className}Status.success) {
            return const Center(child: Text("✅ Success"));
          } else if (state.status == ${className}Status.error) {
            return Center(child: Text(state.message ?? '❌ Error'));
          }

          return Scaffold(
            appBar: AppBar(title: const Text('$className')),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<${className}Cubit>().example();
                },
                child: const Text('Trigger Example'),
              ),
            ),
          );
        },
      ),
    );
  }
}
''');

  // === 4. إنشاء utils في lib/core/utils
  final utilsDir = Directory('lib/core/utils');
  if (!utilsDir.existsSync()) {
    utilsDir.createSync(recursive: true);
    print('✅ Created: lib/core/utils');
  }

  final navHelperFile = File('lib/core/utils/navigation_helper.dart');
  _writeFileIfNotExists(navHelperFile, _navigationHelperContent());

  // === 5. تم ===
  print('\n📂 Folder structure created under lib/features/$feature');
  print('📁 Includes model, service, repository (abstract + impl), cubit, state, view');
  print('🎉 Feature "$feature" created with full clean MVVM + Repository + Service structure!');
}

String _capitalize(String s) =>
    s.split('_').map((e) => e[0].toUpperCase() + e.substring(1)).join();

void _writeFileIfNotExists(File file, String content) {
  if (!file.existsSync()) {
    file.writeAsStringSync(content);
    print('📝 Created file: ${file.path}');
  } else {
    print('⚠️  File already exists: ${file.path}');
  }
}

String _navigationHelperContent() => '''
import 'package:flutter/material.dart';

enum TransitionType { slideFromBottom, fade, scale }

Future<T?> navigateWithTransition<T>(
  BuildContext context,
  Widget page, {
  TransitionType type = TransitionType.slideFromBottom,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return Navigator.of(context).push<T>(
    PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.slideFromBottom:
            final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));
            return SlideTransition(position: animation.drive(tween), child: child);
        }
      },
    ),
  );
}
''';
