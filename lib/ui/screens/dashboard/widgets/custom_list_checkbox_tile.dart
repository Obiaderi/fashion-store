import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

class CustomListCheckboxTile extends StatelessWidget {
  const CustomListCheckboxTile({
    Key? key,
    this.isSelected = false,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final bool? isSelected;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.width(16),
          vertical: Sizer.height(13),
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected! ? AppColor.red : AppColor.grey200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Sizer.text(14),
                fontWeight: FontWeight.w500,
                color: isSelected! ? AppColor.brandBlue : AppColor.grey200,
              ),
            ),
            Container(
              height: Sizer.height(20),
              width: Sizer.width(20),
              padding: EdgeInsets.all(
                Sizer.width(1),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected! ? AppColor.red : AppColor.grey200,
                ),
              ),
              child: isSelected!
                  ? Container(
                      height: Sizer.height(20),
                      width: Sizer.width(20),
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColor.grey200),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
