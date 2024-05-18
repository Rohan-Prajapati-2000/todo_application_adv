import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class SaveAndCancelButton extends StatelessWidget {
  const SaveAndCancelButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: SColors.secondaryColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Text(title, style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black)));
  }
}
