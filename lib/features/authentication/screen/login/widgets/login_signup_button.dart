import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/authentication/screen/login/login_screen.dart';
import 'package:todo_app/features/authentication/screen/signup/signup_screen.dart';
import 'package:todo_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class Row_Login_Signup_Button extends StatelessWidget {
  const Row_Login_Signup_Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: 40,
                  child: TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: dark ? Colors.white : SColors.darkerGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(SSizes.buttonRadius),
                                bottomLeft: Radius.circular(SSizes.buttonRadius),
                              ))),
                      onPressed: () => Get.to(()=> LoginScreen()),
                      child: Text(
                        ' Login ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: dark ? Colors.black : Colors.white),
                      )))
            ],
          ),
        ),
        Container(width: 2,height: 40, color: Colors.redAccent),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 40,
                  child: TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: dark ? Colors.white : SColors.darkerGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(SSizes.buttonRadius),
                                bottomRight: Radius.circular(SSizes.buttonRadius),
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ))),
                      onPressed: () => Get.to(()=> SignupScreen()),
                      child: Text(
                        'Signup',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: dark ? Colors.black : Colors.white),
                      )))
            ],
          ),
        ),
      ],
    );
  }
}
