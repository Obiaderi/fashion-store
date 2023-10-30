import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

class ProductCategoryCard extends StatelessWidget {
  const ProductCategoryCard({
    Key? key,
    this.isSelected = false,
    required this.name,
    this.onTap,
  }) : super(key: key);

  final String name;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.width(10),
          vertical: Sizer.height(4),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer.radius(10)),
          border: Border.all(
            color: isSelected ? AppColor.debitOrange : AppColor.brandBlue,
            width: 1,
          ),
        ),
        child: Center(
          child: Styles.regular(
            name,
            color: isSelected ? AppColor.debitOrange : AppColor.brandBlue,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
