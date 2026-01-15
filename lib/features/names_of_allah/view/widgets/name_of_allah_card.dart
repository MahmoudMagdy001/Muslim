import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/names_of_allah_model.dart';
import '../../../../core/utils/extensions.dart';

class NameOfAllahCard extends StatelessWidget {
  const NameOfAllahCard({
    required this.data,
    required this.index,
    required this.isArabic,
    required this.isSharing,
    required this.onShare,
    super.key,
  });
  final DataItem data;
  final int index;
  final bool isArabic;
  final bool isSharing;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final name = isArabic ? data.name : data.nameTranslation;
    final text = isArabic ? data.text : data.textTranslation;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.toH, horizontal: 8.toW),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.cardGradient(context),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.toR),
      ),
      child: InkWell(
        onTap: () {}, // Keep for ripple effect
        borderRadius: BorderRadius.circular(15.toR),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/quran/marker.png',
                    width: 40.toW,
                    height: 40.toH,
                  ),
                  Text(
                    isArabic
                        ? convertToArabicNumbers((index + 1).toString())
                        : (index + 1).toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.toW),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.toH),
                    Text(
                      '${isArabic ? 'المعني' : 'Meaning'}: $text',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.toW),
              isSharing
                  ? SizedBox(
                      width: 24.toR,
                      height: 24.toR,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                        size: 20.toR,
                      ),
                      onPressed: onShare,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
