import 'package:flutter/material.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

class CustomBtnWithPadding extends StatelessWidget {
  const CustomBtnWithPadding({
    Key? key,
    this.onTap,
    required this.title,
    this.color,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? AppColor.brandBlue,
          borderRadius: BorderRadius.circular(
            Sizer.radius(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Sizer.radius(12),
          horizontal: Sizer.radius(16),
        ),
        child: Center(
          child: Styles.regular(
            title,
            color: AppColor.white,
            fontWeight: FWt.bold,
            fontSize: Sizer.text(16),
          ),
        ),
      ),
    );
  }
}
