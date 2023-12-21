import 'package:bean_app/view/screen/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/dimensions.dart';
import '../../widget/bottom_nav_item.dart';
import '../../widget/cart_widget.dart';
import 'orders/order_screen.dart';

class RootScreen extends StatefulWidget {
  final int idx;

  const RootScreen({super.key, required this.idx});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  String? userId;
  List<Widget> portraitViews = [
    HomePage(),
    OrdersScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.idx;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: portraitViews[_selectedIndex],
        bottomNavigationBar: Container(
          width: Get.size.width,
          height: GetPlatform.isIOS ? 80 : 65,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusLarge)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
            ],
          ),
          child: Stack(
            children: [
              // CustomPaint(size: Size(size.width, GetPlatform.isIOS ? 95 : 80), painter: BNBCustomPainter()),
              Center(
                heightFactor: 0.6,
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).cardColor, width: 5),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, -2),
                            spreadRadius: 0)
                      ]),
                  // margin: EdgeInsets.only(bottom: GetPlatform.isIOS ? 0 : Dimensions.paddingSizeLarge),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      // if (isParcel) {
                      //   showModalBottomSheet(
                      //     context: context,
                      //     isScrollControlled: true,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (con) => ParcelBottomSheet(
                      //         parcelCategoryList: Get.find<ParcelController>()
                      //             .parcelCategoryList),
                      //   );
                      // } else {
                      //   Get.toNamed(RouteHelper.getCartRoute());
                      // }
                    },
                    elevation: 0,
                    child: CartWidget(
                        color: Theme.of(context).cardColor, size: 32),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: Get.size.width,
                  height: 80,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BottomNavItem(
                          title: "Trang chủ",
                          selectedIcon: Icons.home,
                          unSelectedIcon: Icons.home_outlined,
                          isSelected: _selectedIndex == 0,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                        ),
                        BottomNavItem(
                          title: "Đặt hàng",
                          selectedIcon: Icons.fastfood,
                          unSelectedIcon: Icons.fastfood_outlined,
                          isSelected: _selectedIndex == 1,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                        ),
                        Container(width: Get.size.width * 0.2),
                        BottomNavItem(
                          title: "Giao dịch",
                          selectedIcon: Icons.history,
                          unSelectedIcon: Icons.history_outlined,
                          isSelected: _selectedIndex == 2,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                          },
                        ),
                        BottomNavItem(
                          title: "Tài khoản",
                          selectedIcon: Icons.account_box,
                          unSelectedIcon: Icons.account_box_outlined,
                          isSelected: _selectedIndex == 3,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 3;
                            });
                          },
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
