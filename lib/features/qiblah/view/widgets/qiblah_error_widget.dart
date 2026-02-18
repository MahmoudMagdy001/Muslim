import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';
import '../../viewmodel/qiblah_cubit.dart';

class QiblahErrorWidget extends StatelessWidget {
  const QiblahErrorWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64.r, color: Colors.red),
          SizedBox(height: 16.h),
          Text('${l10n.errorMain} $message'),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<QiblahCubit>().init(),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
