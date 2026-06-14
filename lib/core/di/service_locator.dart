import 'package:get_it/get_it.dart';

import 'package:muslim/core/di/register_cubits.dart';
import 'package:muslim/core/di/register_data_sources.dart';
import 'package:muslim/core/di/register_repositories.dart';
import 'package:muslim/core/di/register_use_cases.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  registerDataSources(getIt);
  registerRepositories(getIt);
  registerUseCases(getIt);
  registerCubits(getIt);
}
