import 'package:flutter/material.dart';
import 'package:todo_app/features/authentication/screen/login/widgets/login_form.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/sizes.dart';
import 'package:todo_app/utils/helpers/helper_functions.dart';
import 'package:todo_app/widgets/custom_shape/containers/circular_container.dart';
import 'package:todo_app/widgets/form_divider.dart';
import 'package:todo_app/widgets/social_buttons.dart';

import 'widgets/login_signup_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: SColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SRoundedContainer(
                  width: 380,
                  backgroundColor: dark ? SColors.darkerGrey : SColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(SSizes.defaultSpace),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Login Signup Button
                        Row_Login_Signup_Button(),
                        SLoginForm(),
                      ],
                    ),
                  ),
                ),
          
                SizedBox(height: SSizes.spaceBtwSections),
          
                SFormDivider(dividerText: 'or login with'),
          
                SizedBox(height: SSizes.spaceBtwSections),
          
                SSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
