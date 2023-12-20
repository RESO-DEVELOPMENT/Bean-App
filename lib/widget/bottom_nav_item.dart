import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../utils/styles.dart';

class BottomNavItem extends StatelessWidget {
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  const BottomNavItem(
      {Key? key,
      this.onTap,
      this.isSelected = false,
      required this.title,
      required this.selectedIcon,
      required this.unSelectedIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as Function()?,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            isSelected ? selectedIcon : unSelectedIcon,
            size: 25,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          // Image.asset(
          //   isSelected ? selectedIcon : unSelectedIcon,
          //   height: 25,
          //   width: 25,
          //   color: isSelected
          //       ? Theme.of(context).primaryColor
          //       : Theme.of(context).textTheme.bodyMedium!.color!,
          // ),
          SizedBox(
              height: isSelected
                  ? Dimensions.paddingSizeExtraSmall
                  : Dimensions.paddingSizeSmall),
          Text(
            title,
            style: robotoRegular.copyWith(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyMedium!.color!,
                fontSize: 12),
          ),
        ]),
      ),
    );
  }
}
