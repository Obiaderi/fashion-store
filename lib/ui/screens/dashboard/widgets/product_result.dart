import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/helpers/format_currency.dart';
import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

class ProductResult extends StatelessWidget {
  const ProductResult({
    super.key,
    required this.product,
    this.onTapLike,
    this.isFavourite = false,
    this.onTap,
  });
  final bool isFavourite;
  final Function()? onTapLike;
  final ProductModel product;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizer.width(166.5),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(Sizer.radius(8)),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizer.radius(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    product.image ?? "",
                    height: Sizer.height(211),
                    width: Sizer.width(166.5),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: Sizer.radius(0),
                    right: Sizer.radius(0),
                    child: IconButton(
                      onPressed: onTapLike,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavourite ? AppColor.brandBlue : AppColor.black,
                        size: Sizer.radius(22),
                      ),
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              const VSpace(8),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.category?.name ?? "",
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: Sizer.text(12),
                          fontWeight: FontWeight.w400,
                        )),
                    Text(
                      product.name ?? "",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: Sizer.text(12),
                        fontWeight: FWt.semiBold,
                      ),
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          'N${formatCurrencyWithoutDecimal.format(
                            (double.tryParse((product.price ?? "0")) ?? 0),
                          )}',
                          style: TextStyle(
                            color: AppColor.brandBlack,
                            fontSize: Sizer.text(12),
                            fontWeight: FWt.semiBold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const HSpace(8),
                        Text(
                          'N${formatCurrencyWithoutDecimal.format(
                            (double.tryParse((product.salesPrice ?? "0")) ?? 0),
                          )}',
                          style: TextStyle(
                            color: AppColor.brandOrange,
                            fontSize: Sizer.text(12),
                            fontWeight: FWt.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
