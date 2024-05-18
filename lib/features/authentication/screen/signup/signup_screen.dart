import 'package:flutter/material.dart';
import 'package:todo_app/features/authentication/screen/login/widgets/login_signup_button.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/sizes.dart';
import 'package:todo_app/utils/helpers/helper_functions.dart';
import 'package:todo_app/widgets/custom_shape/containers/circular_container.dart';
import '../../../../widgets/form_divider.dart';
import '../../../../widgets/social_buttons.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget{
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: SColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SRoundedContainer(
                  width: 380,
                  backgroundColor: dark ? SColors.darkerGrey : Colors.white,
                  padding: EdgeInsets.all(SSizes.defaultSpace),
                  child: Column(
                    children: [
                      Row_Login_Signup_Button(),
                      SizedBox(height: SSizes.spaceBtwItems),
                      SSignupForm(),
                    ],
                  )
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