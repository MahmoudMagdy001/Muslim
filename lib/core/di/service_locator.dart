import 'package:get_it/get_it.dart';

import 'register_cubits.dart';
import 'register_data_sources.dart';
import 'register_repositories.dart';
import 'register_use_cases.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  registerDataSources(getIt);
  registerRepositories(getIt);
  registerUseCases(getIt);
  registerCubits(getIt);
}
