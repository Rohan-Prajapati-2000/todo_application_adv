import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../controllers/sign_up/signup_controller.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                /// First Name
                Expanded(
                    child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      SValidator.validateEmptyText('First Name', value),
                  decoration: const InputDecoration(
                      labelText: SText.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
                const SizedBox(width: SSizes.spaceBtwInputField),

                /// Second Name
                Expanded(
                    child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      SValidator.validateEmptyText('Last Name', value),
                  decoration: const InputDecoration(
                      labelText: SText.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwInputField),

            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => SValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: SText.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(height: SSizes.spaceBtwInputField),

            /// Phone Number
            TextFormField(
              validator: (value) => SValidator.validatePhoneNumber(value!),
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                  labelText: SText.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(height: SSizes.spaceBtwInputField),

            /// Password
            Obx(
              () => TextFormField(
                validator: (value) => SValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: SText.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                  ),
                ),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwInputField),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.signUp(),
                    child: const Text(SText.createAccount)))
          ],
        ));
  }
}
