import 'package:flutter/material.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/screens/dashboard/widgets/product_result.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

class HomeProduct extends StatelessWidget {
  const HomeProduct({
    Key? key,
    required this.products,
    required this.title,
    this.isSlider = false,
  }) : super(key: key);

  final List<ProductModel> products;
  final String title;
  final bool isSlider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: Sizer.width(16),
            bottom: Sizer.height(8),
          ),
          child: Styles.regular(
            title,
            color: AppColor.black,
            fontSize: 16,
            fontWeight: FWt.bold,
          ),
        ),
        isSlider
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var product in products)
                      Container(
                        padding: EdgeInsets.only(
                          left: Sizer.width(16),
                        ),
                        child: ProductResult(
                          product: product,
                          onTapLike: () {},
                          isFavourite: false,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.productDetail,
                              arguments: product,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              )
            : GridView.count(
                childAspectRatio: 200 / 320,
                crossAxisSpacing: Sizer.width(16),
                mainAxisSpacing: Sizer.height(16),
                padding: EdgeInsets.only(left: Sizer.width(16)),
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (var product in products)
                    ProductResult(
                      product: product,
                      onTapLike: () {},
                      isFavourite: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.productDetail,
                          arguments: product,
                        );
                      },
                    ),
                ],
              ),
      ],
    );
  }
}
