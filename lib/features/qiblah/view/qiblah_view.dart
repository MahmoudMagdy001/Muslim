import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/qiblah_cubit.dart';
import '../viewmodel/qiblah_state.dart';
import 'widgets/compass_widget.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(localizations.qiblahDirection)),
      body: SafeArea(
        child: BlocBuilder<QiblahCubit, QiblahState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.qiblahAngle != current.qiblahAngle,
          builder: (context, state) {
            if (state.status == QiblahStatus.error) {
              return _QiblahErrorWidget(
                message: state.message ?? '',
                localizations: localizations,
              );
            } else {
              return QiblahSuccessWidget(
                headingAngle: state.headingAngle,
                qiblahAngle: state.qiblahAngle,
                isAligned: state.isAligned,

                isLoading: state.status == QiblahStatus.loading,
                localizations: localizations,
                isArabic: isArabic,
              );
            }
          },
        ),
      ),
    );
  }
}

class QiblahSuccessWidget extends StatelessWidget {
  const QiblahSuccessWidget({
    required this.headingAngle,
    required this.qiblahAngle,
    required this.isAligned,
    required this.isLoading,
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;
  final bool isLoading;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      children: [
        Expanded(
          child: CompassWidget(
            headingAngle: headingAngle,
            qiblahAngle: qiblahAngle,
            isAligned: isAligned,
            isLoading: isLoading,
            localizations: localizations,
          ),
        ),
      ],
    ),
  );
}

class _QiblahErrorWidget extends StatelessWidget {
  const _QiblahErrorWidget({
    required this.message,
    required this.localizations,
  });

  final String message;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        Text('${localizations.errorMain} $message'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<QiblahCubit>().init();
          },
          child: Text(localizations.retry),
        ),
      ],
    ),
  );
}
