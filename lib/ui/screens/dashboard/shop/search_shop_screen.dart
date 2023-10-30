import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/helpers/log_state.dart';
import 'package:lightsonheights/core/providers/product_vm.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/shared/shimmer/product_shimmer.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

import '../widgets/product_result.dart';

class SearchShopScreen extends StatefulWidget {
  const SearchShopScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  State<SearchShopScreen> createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductVM>().getProductsBySearch(widget.query);
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
                    widget.query,
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
                if (vm.searchProducts.isEmpty) {
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
                          for (var product in vm.searchProducts)
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
