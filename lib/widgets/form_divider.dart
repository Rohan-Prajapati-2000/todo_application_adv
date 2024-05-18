import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class SFormDivider extends StatelessWidget {
  SFormDivider({
    super.key, required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
                color: SColors.white,
                thickness: 1.5,
                indent: 60,
                endIndent: 5)),
        Text(dividerText,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black)),
        Flexible(
            child: Divider(
                color: SColors.white,
                thickness: 1.5,
                indent: 5,
                endIndent: 60)),
      ],
    );
  }
}