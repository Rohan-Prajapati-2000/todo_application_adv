import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'reset_password.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFromKey = GlobalKey<FormState>();

  /// Send Reset Email
  sendPasswordResetEmail() async{
    try{
      /// Start Loading
      SFullScreenLoaders.openLoadingDialog('Processing your request...', SImage.loadingAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoaders.stopLoading();
        return;
      }
      if(!forgetPasswordFromKey.currentState!.validate()){
        SFullScreenLoaders.stopLoading();
        return;
      }

      /// Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.toString());

      /// Remove Loader
      SFullScreenLoaders.stopLoading();

      /// Show success screen
      SLoaders.successSnackBar(title: "Email Sent", message: 'Email Link Sent to Reset Your Password'.tr);

      /// Redirect to the next screen
      Get.to(()=> ResetPasswordScreen(email: email.text.toString()));

    } catch (e) {
      SFullScreenLoaders.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      /// Start Loading
      SFullScreenLoaders.openLoadingDialog('Processing your request...', SImage.loadingAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoaders.stopLoading();
        return;
      }

      /// Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Remove Loader
      SFullScreenLoaders.stopLoading();

      /// Show success screen
      SLoaders.successSnackBar(title: "Email Sent", message: 'Email Link Sent to Reset Your Password'.tr);

    } catch (e) {
      SFullScreenLoaders.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }



}