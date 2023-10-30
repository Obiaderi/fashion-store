import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/helpers/log_state.dart';
import 'package:lightsonheights/core/providers/product_vm.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/screens/dashboard/bottomsheets/filter_product_sheet.dart';
import 'package:lightsonheights/ui/shared/bs_wrapper.dart';
import 'package:lightsonheights/ui/shared/shimmer/product_shimmer.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';
import 'package:provider/provider.dart';

import '../bottomsheets/sort_product_sheet.dart';
import '../widgets/product_result.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductVM>().getProducts();
    });
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (context.read<ProductVM>().paginatedState == ViewState.busy) {
        return;
      }
      Console.log("Scrolling");
      context.read<ProductVM>().getMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: AppColor.brandBlue,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.width(16),
                vertical: Sizer.height(20),
              ),
              color: AppColor.brandBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Styles.regular(
                    'SHOP SCREEN',
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FWt.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ProductVM>(
        builder: (context, vm, child) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                  vertical: Sizer.height(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BsWrapper.bottomSheet(
                          context: context,
                          widget: const SortProductSheet(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizer.width(20),
                          vertical: Sizer.height(10),
                        ),
                        child: Row(
                          children: [
                            Text("SORT",
                                style: TextStyle(
                                  fontSize: Sizer.text(16),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.grey200,
                                )),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: AppColor.grey200,
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.orange,
                      thickness: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        BsWrapper.bottomSheet(
                          context: context,
                          widget: const FilterProductSheet(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizer.width(20),
                          vertical: Sizer.height(10),
                        ),
                        child: Text("FILTER",
                            style: TextStyle(
                              fontSize: Sizer.text(16),
                              fontWeight: FontWeight.w600,
                              color: AppColor.grey200,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColor.lightGrey,
                height: 1,
              ),
              Builder(builder: (context) {
                if (vm.state == ViewState.busy) {
                  return Expanded(
                    child: ListView(
                      children: const [
                        ProductShimmer(
                          child: GridProductShimmerWidget(),
                        ),
                      ],
                    ),
                  );
                }
                if (vm.products.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text("No Products"),
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: Sizer.height(16),
                      bottom: Sizer.height(150),
                    ),
                    children: [
                      GridView.count(
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
                          for (var product in vm.products)
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
                      SizedBox(height: Sizer.height(20)),
                      if (vm.paginatedState == ViewState.busy)
                        ProductShimmer(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: Sizer.width(16),
                              right: Sizer.width(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: generateShimmerContainer(2),
                            ),
                          ),
                        )
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
