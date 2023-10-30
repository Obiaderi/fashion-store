import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/helpers/format_currency.dart';

import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/core/providers/cart_vm.dart';
import 'package:lightsonheights/core/providers/category_vm.dart';
import 'package:lightsonheights/ui/shared/custom_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';
import 'package:provider/provider.dart';

import '../home/home_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  final ProductModel? product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCategoryVM>().getRelatedProducts(
            widget.product!.category!,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Sizer.height(400),
              color: AppColor.blue,
              child: Stack(
                children: [
                  SizedBox(
                    height: Sizer.height(400),
                    width: Sizer.screenWidth,
                    child: Image.asset(
                      widget.product!.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: Sizer.radius(40),
                    child: Container(
                      width: Sizer.screenWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizer.width(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: Sizer.radius(40),
                              height: Sizer.radius(40),
                              decoration: BoxDecoration(
                                color: AppColor.brandBlue,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColor.white,
                                size: Sizer.radius(25),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.favorite_border,
                              color: AppColor.black,
                              size: Sizer.radius(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: Sizer.height(10),
                left: Sizer.width(16),
                right: Sizer.width(16),
                bottom: Sizer.height(40),
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizer.radius(20)),
                  bottomRight: Radius.circular(Sizer.radius(20)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.regular(
                    widget.product!.name!,
                    color: AppColor.black,
                    fontSize: 20,
                    fontWeight: FWt.bold,
                  ),
                  Styles.regular(
                    widget.product!.category!.name!,
                    color: AppColor.grey,
                    fontSize: 12,
                    fontWeight: FWt.regular,
                  ),
                  Row(
                    children: [
                      Text(
                        'N${formatCurrencyWithoutDecimal.format(
                          (double.tryParse((widget.product!.price ?? "0")) ??
                              0),
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
                          (double.tryParse(
                                  (widget.product!.salesPrice ?? "0")) ??
                              0),
                        )}',
                        style: TextStyle(
                          color: AppColor.brandOrange,
                          fontSize: Sizer.text(12),
                          fontWeight: FWt.semiBold,
                        ),
                      ),
                    ],
                  ),
                  const VSpace(8),
                  Styles.regular(
                    widget.product!.description!,
                    color: AppColor.grey,
                    fontSize: 14,
                    fontWeight: FWt.regular,
                  ),
                ],
              ),
            ),
            const VSpace(30),
            Consumer<ProductCategoryVM>(builder: (context, productVM, _) {
              if (productVM.viewState == ViewState.busy) {
                return SizedBox(
                  height: Sizer.height(100),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return HomeProduct(
                products: productVM.relatedProducts,
                title: 'Related Products',
                isSlider: true,
              );
            }),
            const VSpace(140),
          ],
        ),
      ),
      bottomSheet: Container(
        height: Sizer.height(80),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CustomBtn(
          title: 'Add to Cart',
          onTap: () {
            context.read<CartVM>().addToCart(widget.product!);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
