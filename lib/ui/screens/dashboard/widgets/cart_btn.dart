import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

class CartBtn extends StatelessWidget {
  const CartBtn({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.brandBlue,
          ),
        ),
        padding: EdgeInsets.all(
          Sizer.radius(3),
        ),
        child: Icon(
          icon,
          size: Sizer.text(16),
          color: AppColor.brandBlue,
        ),
      ),
    );
  }
}
