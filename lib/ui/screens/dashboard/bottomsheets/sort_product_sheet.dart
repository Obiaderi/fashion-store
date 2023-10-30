import 'package:flutter/material.dart';
import 'package:lightsonheights/core/providers/product_vm.dart';
import 'package:lightsonheights/ui/shared/pop_out_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_list_checkbox_tile.dart';

class SortProductSheet extends StatelessWidget {
  const SortProductSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductVM>(builder: (context, vm, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
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
                  "Sort Products",
                  style: TextStyle(
                    fontSize: Sizer.text(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(),
              ],
            ),
          ),
          const VSpace(16),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.width(16),
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              String title = "";
              if (vm.sortEnumValues[index] == SortEnum.lowPrice) {
                title = "Price: Low to High";
              } else if (vm.sortEnumValues[index] == SortEnum.highPrice) {
                title = "Price: High to Low";
              } else if (vm.sortEnumValues[index] == SortEnum.alphaAsc) {
                title = "A to Z";
              } else if (vm.sortEnumValues[index] == SortEnum.alphaDesc) {
                title = "Z to A";
              } else {
                title = "Recommended";
              }
              return CustomListCheckboxTile(
                title: title,
                isSelected: vm.sortEnumValues[index] == vm.selectedSort,
                onTap: () {
                  vm.setSelectedSortedProducts(vm.sortEnumValues[index]);
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (ctx, index) => SizedBox(
              height: Sizer.height(10),
            ),
            itemCount: vm.sortEnumValues.length,
          ),
          const VSpace(30),
        ],
      );
    });
  }
}
