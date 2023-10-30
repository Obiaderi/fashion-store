import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      child: child,
    );
  }
}

class GridProductShimmerWidget extends StatelessWidget {
  const GridProductShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 200 / 320,
      crossAxisSpacing: Sizer.width(16),
      mainAxisSpacing: Sizer.height(16),
      padding: EdgeInsets.only(
        left: Sizer.width(16),
        top: Sizer.height(16),
      ),
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: generateShimmerContainer(4),
    );
  }
}

class ProductShimmerWidget extends StatelessWidget {
  const ProductShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizer.height(280),
      child: ListView.builder(
        padding: EdgeInsets.only(left: Sizer.width(16)),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Sizer.width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white,
                  ),
                  width: Sizer.width(166.5),
                  height: Sizer.height(211),
                ),
                const VSpace(8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.white,
                  ),
                  width: Sizer.width(166.5),
                  height: Sizer.height(10),
                ),
                const VSpace(4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.white,
                  ),
                  width: Sizer.width(166.5),
                  height: Sizer.height(10),
                ),
                const VSpace(4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.white,
                  ),
                  width: Sizer.width(166.5),
                  height: Sizer.height(10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SingleProductShimmer extends StatelessWidget {
  const SingleProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
          ),
          width: Sizer.width(166.5),
          height: Sizer.height(211),
        ),
        const VSpace(8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.white,
          ),
          width: Sizer.width(166.5),
          height: Sizer.height(10),
        ),
        const VSpace(4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.white,
          ),
          width: Sizer.width(166.5),
          height: Sizer.height(10),
        ),
        const VSpace(4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.white,
          ),
          width: Sizer.width(166.5),
          height: Sizer.height(10),
        ),
      ],
    );
  }
}

List<Widget> generateShimmerContainer(int length) {
  List<Widget> shimmerContainer = [];
  for (int i = 0; i < length; i++) {
    shimmerContainer.add(const SingleProductShimmer());
  }
  return shimmerContainer;
}
