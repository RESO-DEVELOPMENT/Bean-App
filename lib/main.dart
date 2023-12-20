import 'dart:io';
import 'dart:ui';

import 'package:bean_app/setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helper/responsive_helper.dart';
import 'theme/light_theme.dart';
import 'utils/app_constants.dart';
import 'utils/request.dart';
import 'utils/route_constrant.dart';
import 'view/screen/login/login.dart';
import 'view/screen/login/login_otp.dart';
import 'view/screen/not_found_screen.dart';
import 'view/screen/root_screen.dart';
import 'view/screen/splash_screen.dart';

void main() {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  createRouteBindings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      theme: light(),
      // locale: localizeController.locale,
      // translations: Messages(languages: widget.languages),

      getPages: [
        GetPage(
            name: RouteHandler.WELCOME,
            page: () => const SplashScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.LOGIN,
            page: () => const LoginScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.OTP,
            page: () => const MyOtp(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.HOME,
            page: () => RootScreen(
                  idx: int.parse(Get.parameters['idx'] ?? '0'),
                ),
            transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.CART,
        //     page: () => const CartScreen(),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.VOUCHER,
        //     page: () => const Voucher(),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.ORDER,
        //     page: () => const OrderHistory(),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.TRANSACTIONS,
        //     page: () => const TransactionsHistory(),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.PRODUCT_DETAIL,
        //     page: () => Option(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.VOUCHER_DETAIL,
        //     page: () => VoucherDetails(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.PROMOTION_DETAILS,
        //     page: () => PromotionDetailsScreen(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.ORDER_DETAILS,
        //     page: () => OrderDetails(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.CATEGORY_DETAIL,
        //     page: () => CategoryDetailsScreen(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.COLLECTION_DETAIL,
        //     page: () => CollectionDetailsScreen(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.BLOG,
        //     page: () => BannerDetailScreen(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.STORE,
        //     page: () => StoreDetailScreen(
        //           id: Get.parameters['id'] ?? '',
        //         ),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.POLICY,
        //     page: () => const PolicyPage(),
        //     transition: Transition.cupertino),
        // GetPage(
        //     name: RouteHandler.QR,
        //     page: () => const QrScreen(),
        //     transition: Transition.downToUp),
        // GetPage(
        //     name: RouteHandler.STORES,
        //     page: () => const Store(),
        //     transition: Transition.cupertino)
      ],
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      initialRoute: RouteHandler.WELCOME,
      unknownRoute: GetPage(
          name: RouteHandler.NOT_FOUND, page: () => const NotFoundScreen()),
      home: const SplashScreen(),
    );
  }
}
