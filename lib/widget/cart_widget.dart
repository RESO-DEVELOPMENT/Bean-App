import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/images.dart';
import '../utils/styles.dart';

class CartWidget extends StatelessWidget {
  final Color? color;
  final double size;
  final bool fromStore;
  const CartWidget(
      {Key? key,
      required this.color,
      required this.size,
      this.fromStore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Icon(
        Icons.qr_code_2,
        color: Colors.white,
        size: size,
      ),
    ]);
  }
}
