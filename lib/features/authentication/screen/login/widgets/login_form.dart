import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../controllers/login/login_controller.dart';
import '../../password_configuration/forget_password.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => SValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: SText.email),
            ),
            const SizedBox(height: SSizes.spaceBtwInputField),

            /// Password
            Obx(
                  () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    SValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: SText.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwInputField / 2),

            // Remember Me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  children: [
                    Obx(
                          () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value),
                    ),
                    const Text(SText.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(SText.forgetPassword)),
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(SText.signIn))),
            const SizedBox(height: SSizes.spaceBtwItems),

          ],
        ),
      ),
    );
  }
}
