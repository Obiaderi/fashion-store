import 'package:flutter/material.dart';
import 'package:lightsonheights/ui/shared/custom_btn_with_padding.dart';
import 'package:provider/provider.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/models/product_category.dart';
import 'package:lightsonheights/core/providers/product_vm.dart';
import 'package:lightsonheights/ui/shared/pop_out_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

class FilterProductSheet extends StatefulWidget {
  const FilterProductSheet({super.key});

  @override
  State<FilterProductSheet> createState() => _FilterProductSheetState();
}

class _FilterProductSheetState extends State<FilterProductSheet> {
  List<PriceRanges> get priceRanges => PriceRanges.values;

  int selectedCategoryIndex = -1;
  List<FilterMethod> filterNum = [];
  ProductCategory? selectedCategory;
  PriceRanges? selectedPriceRange;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductVM>(
      builder: (context, vm, _) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                  vertical: Sizer.height(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PopOutBtn(),
                    Text(
                      "Filter Products",
                      style: TextStyle(
                        fontSize: Sizer.text(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: Sizer.width(16),
              //   ).copyWith(bottom: Sizer.height(10)),
              //   child: Styles.regular(
              //     "By Categories",
              //     fontSize: 18,
              //     fontWeight: FWt.bold,
              //   ),
              // ),
              // ListView.separated(
              //   shrinkWrap: true,
              //   padding: EdgeInsets.symmetric(
              //     horizontal: Sizer.width(16),
              //   ),
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (ctx, index) {
              //     ProductCategory category =
              //         ProductCategory.getProductCategories()[index];
              //     return FilterListTile(
              //       title: category.name!,
              //       isSelected: selectedCategoryIndex == index,
              //       onTap: () {
              //         setState(() {
              //           selectedCategoryIndex = index;
              //           selectedCategory = category;
              //           if (!filterNum.contains(FilterMethod.category)) {
              //             filterNum.add(FilterMethod.category);
              //           }
              //         });
              //       },
              //     );
              //   },
              //   separatorBuilder: (ctx, index) => SizedBox(
              //     height: Sizer.height(10),
              //   ),
              //   itemCount: ProductCategory.getProductCategories().length,
              // ),
              const VSpace(30),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                ).copyWith(bottom: Sizer.height(10)),
                child: Styles.regular(
                  "By Price",
                  fontSize: 18,
                  fontWeight: FWt.bold,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  String price = "";
                  if (priceRanges[index] == PriceRanges.below1000) {
                    price = "Below 1000";
                  } else if (priceRanges[index] ==
                      PriceRanges.between1000And2000) {
                    price = "1000 and 2000";
                  } else if (priceRanges[index] ==
                      PriceRanges.between2000And3000) {
                    price = "2000 and 3000";
                  } else if (priceRanges[index] ==
                      PriceRanges.between3000And4000) {
                    price = "3000 and 4000";
                  } else {
                    price = "Above 4000";
                  }
                  return FilterListTile(
                    title: price,
                    isSelected: selectedPriceRange == priceRanges[index],
                    onTap: () {
                      setState(() {
                        selectedPriceRange = priceRanges[index];
                        if (!filterNum.contains(FilterMethod.price)) {
                          filterNum.add(FilterMethod.price);
                        }
                      });
                    },
                  );
                },
                separatorBuilder: (ctx, index) => SizedBox(
                  height: Sizer.height(10),
                ),
                itemCount: priceRanges.length,
              ),
              const VSpace(30),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                ).copyWith(bottom: Sizer.height(20)),
                child: CustomBtnWithPadding(
                  title:
                      ' Apply Filter ${filterNum.isNotEmpty ? '(${filterNum.length})' : ''}',
                  onTap: selectedPriceRange == null
                      ? null
                      : () {
                          vm.getProductsByPriceRange(selectedPriceRange!);
                          Navigator.pop(context);
                        },
                  color: selectedPriceRange == null
                      ? AppColor.grey200
                      : AppColor.brandBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FilterListTile extends StatelessWidget {
  const FilterListTile({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: Sizer.height(16),
            width: Sizer.width(16),
            padding: EdgeInsets.all(
              Sizer.width(1),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColor.red : AppColor.grey200,
              ),
            ),
            child: isSelected
                ? Container(
                    height: Sizer.height(16),
                    width: Sizer.width(16),
                    decoration: BoxDecoration(
                      color: AppColor.red,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColor.grey200),
                    ),
                  )
                : Container(),
          ),
          const HSpace(10),
          Text(
            title,
            style: TextStyle(
              fontSize: Sizer.text(14),
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColor.brandBlue : AppColor.grey200,
            ),
          ),
        ],
      ),
    );
  }
}
