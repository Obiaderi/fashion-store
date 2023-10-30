import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/models/product_category.dart';
import 'package:lightsonheights/core/providers/cart_vm.dart';
import 'package:lightsonheights/core/providers/category_vm.dart';
import 'package:lightsonheights/core/providers/product_vm.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/screens/dashboard/home/home_product.dart';
import 'package:lightsonheights/ui/shared/form_manager.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';
import 'package:provider/provider.dart';

import '../../../shared/shimmer/product_shimmer.dart';
import '../widgets/product_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductVM>().getTrendingProducts();
      context.read<ProductCategoryVM>().getHomeProductsByCategory(
            ProductCategory.getProductCategories().first,
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  onSubmitted(BuildContext context, String query) async {
    if (query.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    searchController.text = "";
    Navigator.pushNamed(context, Routes.searchShopScreen, arguments: query);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Styles.regular(
                    'Welcome Edobor',
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FWt.bold,
                  ),
                  Consumer<CartVM>(builder: (context, cartVM, _) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.cart);
                      },
                      child: badges.Badge(
                        badgeContent: Text(
                          cartVM.cartItems.isEmpty
                              ? '0'
                              : '${cartVM.cartItems.length}',
                        ),
                        badgeAnimation: const badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ProductCategoryVM>(builder: (context, catVM, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.width(16),
                  vertical: Sizer.height(10),
                ),
                child: CustomTextField(
                  hintText: 'Search for products',
                  hintTextStyle: TextStyle(
                      color: AppColor.grey200, fontSize: Sizer.text(15)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.grey200,
                    size: Sizer.radius(30),
                  ),
                  controller: searchController,
                  onFieldSubmitted: (query) => onSubmitted(context, query),
                ),
              ),
              SizedBox(height: Sizer.height(10)),
              SizedBox(
                height: Sizer.height(40),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizer.width(16), vertical: Sizer.height(2)),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    ProductCategory productCategory =
                        ProductCategory.getProductCategories().elementAt(index);
                    return ProductCategoryCard(
                      name: productCategory.name!,
                      isSelected: _selectedCategoryIndex == index,
                      onTap: () => setState(() {
                        _selectedCategoryIndex = index;
                        catVM.getHomeProductsByCategory(productCategory);
                      }),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: Sizer.width(10)),
                  itemCount: ProductCategory.getProductCategories().length,
                ),
              ),
              Builder(builder: (context) {
                if (catVM.viewState == ViewState.busy) {
                  return const ProductShimmer(
                    child: GridProductShimmerWidget(),
                  );
                }
                return Column(
                  children: [
                    if (catVM.productsUnderHomeCategory.isNotEmpty)
                      const VSpace(20),
                    if (catVM.productsUnderHomeCategory.isNotEmpty)
                      HomeProduct(
                        products: catVM.productsUnderHomeCategory,
                        title: "${catVM.category!.name}",
                      ),
                  ],
                );
              }),
              Consumer<ProductVM>(
                builder: (context, productVM, _) {
                  return catVM.productsUnderHomeCategory.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            const VSpace(20),
                            HomeProduct(
                                products: productVM.trendingProducts,
                                title: "Trending Products"),
                            const VSpace(100),
                          ],
                        );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
