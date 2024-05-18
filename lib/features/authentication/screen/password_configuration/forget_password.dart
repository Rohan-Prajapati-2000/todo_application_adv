import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validator.dart';
import '../../controllers/forget_password/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(SText.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text(SText.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: SSizes.spaceBtwSections * 2),

            /// Text Field
            Form(
              key: controller.forgetPasswordFromKey,
              child: TextFormField(
                controller: controller.email,
                validator: SValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: SText.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            /// Submit Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.sendPasswordResetEmail(), child: const Text(SText.submit)))
          ],
        ),
      ),
    );
  }
}
