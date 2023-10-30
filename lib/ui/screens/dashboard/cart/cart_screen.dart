import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/helpers/format_currency.dart';
import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/core/providers/cart_vm.dart';
import 'package:lightsonheights/ui/shared/bs_wrapper.dart';
import 'package:lightsonheights/ui/shared/custom_btn_with_padding.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';
import 'package:provider/provider.dart';

import '../bottomsheets/cart_success_sheet.dart';
import '../widgets/cart_btn.dart';
import 'cart_empty.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List carts = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<CartVM>(builder: (context, cartVM, child) {
      return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          backgroundColor: AppColor.white,
          elevation: 0.0,
          title: Styles.regular(
            "Shopping Cart",
            fontSize: Sizer.text(16),
            fontWeight: FWt.xxBold,
          ),
        ),
        body: cartVM.cartItems.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartEmpty(),
                ],
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizer.radius(10),
                        horizontal: Sizer.radius(16)),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.lightGrey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: AppColor.red,
                        ),
                        const SizedBox(width: 5),
                        Styles.regular(
                          "Swipe left to delete items ",
                          color: AppColor.grey200,
                          fontSize: Sizer.text(12),
                        ),
                      ],
                    ),
                  ),
                  const VSpace(16),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return CartProductInfoCard(
                                product: cartVM.cartItems[index],
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                            itemCount: cartVM.cartItems.length,
                          ),
                          const VSpace(60),
                          Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizer.radius(10),
                                horizontal: Sizer.radius(100),
                              ),
                              child: CustomBtnWithPadding(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  cartVM.clearCart();
                                },
                                title: 'Clear Cart',
                                color: AppColor.brandOrange,
                              )),
                          const VSpace(160),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        bottomSheet: cartVM.cartItems.isEmpty
            ? null
            : Container(
                color: AppColor.white,
                padding: EdgeInsets.symmetric(
                  vertical: Sizer.radius(10),
                  horizontal: Sizer.radius(16),
                ),
                width: double.infinity,
                height: Sizer.height(120),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Styles.regular(
                          "Subtotal- ${cartVM.cartItems.length} item(s)",
                          fontWeight: FWt.semiBold,
                        ),
                        Styles.regular(
                          "N ${formatCurrencyWithoutDecimal.format(cartVM.totalAmount)}",
                          fontWeight: FWt.xxBold,
                          fontSize: Sizer.text(16),
                        ),
                      ],
                    ),
                    const VSpace(10),
                    CustomBtnWithPadding(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        cartVM.clearCart();
                        Navigator.pop(context);
                        BsWrapper.bottomSheet(
                          context: context,
                          widget: const CartSuccessSheet(),
                        );
                      },
                      title: 'Checkout',
                    )
                  ],
                ),
              ),
      );
    });
  }
}

class CartProductInfoCard extends StatefulWidget {
  const CartProductInfoCard({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  State<CartProductInfoCard> createState() => _CartProductInfoCardState();
}

class _CartProductInfoCardState extends State<CartProductInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: true,
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const DrawerMotion(),
        children: <Widget>[
          CustomSlidableAction(
            autoClose: true,
            foregroundColor: Colors.transparent,
            backgroundColor: AppColor.brandOrange,
            onPressed: (context) {
              HapticFeedback.mediumImpact();
              Provider.of<CartVM>(context, listen: false)
                  .removeFromCart(widget.product);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: AppColor.white,
                ),
                const VSpace(8),
                Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: Sizer.text(12),
                    fontWeight: FWt.semiBold,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Sizer.radius(5), horizontal: Sizer.radius(16)),
        child: Row(
          children: [
            Image.asset(
              widget.product.image!,
              width: Sizer.width(90),
              height: Sizer.height(111),
              fit: BoxFit.cover,
            ),
            const HSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.regular(
                    widget.product.name!,
                    fontSize: Sizer.text(12),
                  ),
                  Styles.regular(
                    widget.product.name!,
                    fontSize: Sizer.text(14),
                    fontWeight: FWt.xxBold,
                  ),
                  const VSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CartBtn(
                            icon: Icons.add,
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              context
                                  .read<CartVM>()
                                  .addQuantity(widget.product);
                            },
                          ),
                          const HSpace(16),
                          Center(
                            child: Styles.regular(
                              widget.product.quantitySelected.toString(),
                              fontSize: Sizer.text(16),
                              fontWeight: FWt.semiBold,
                            ),
                          ),
                          const HSpace(16),
                          CartBtn(
                            icon: Icons.remove,
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              context
                                  .read<CartVM>()
                                  .removeQuantity(widget.product);
                            },
                          ),
                        ],
                      ),
                      Styles.regular(
                        "N${formatCurrencyWithoutDecimal.format(double.tryParse((widget.product.salesPrice ?? '0'))! * widget.product.quantitySelected!)}",
                        fontSize: Sizer.text(16),
                        fontWeight: FWt.xxBold,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
