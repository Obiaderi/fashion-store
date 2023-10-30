import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/screens/dashboard/home/home_screen.dart';
import 'package:lightsonheights/ui/screens/dashboard/shop/shop_screen.dart';
import 'package:lightsonheights/ui/shared/bs_wrapper.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

import 'bottomsheets/add_product_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  List screens = [
    const HomeScreen(),
    const ShopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BsWrapper.bottomSheet(
            context: context,
            widget: const AppProductSheet(),
          );
        },
        child: Icon(
          Icons.add,
          size: Sizer.radius(30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: Sizer.height(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: BottomNavColumn(
                  iconData: Icons.home,
                  labelText: 'Home',
                  color:
                      currentIndex == 0 ? AppColor.brandBlue : AppColor.grey200,
                  fontWeight:
                      currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
              ),
              SizedBox(width: Sizer.width(60)),
              Expanded(
                  child: BottomNavColumn(
                iconData: Icons.shop,
                labelText: 'Shop',
                color:
                    currentIndex == 1 ? AppColor.brandBlue : AppColor.grey200,
                fontWeight:
                    currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavColumn extends StatelessWidget {
  const BottomNavColumn({
    Key? key,
    this.icon,
    required this.labelText,
    this.color,
    this.iconData,
    this.isIcon = false,
    required this.fontWeight,
    required this.onPressed,
  }) : super(key: key);

  final String? icon;
  final String labelText;
  final Color? color;
  final IconData? iconData;
  final bool isIcon;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: Sizer.radius(25),
            color: color,
          ),
          SizedBox(height: Sizer.height(4)),
          Text(
            labelText,
            style: TextStyle(
              fontSize: Sizer.text(13),
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
