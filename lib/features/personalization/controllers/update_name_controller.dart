import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import 'user_controller.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when home screen appear
  @override
  void onInit(){
    initializeName();
    super.onInit();
  }

  Future<void> initializeName() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async{
    try{
      // Start Loading
      SFullScreenLoaders.openLoadingDialog('We are updating you information', SImage.loadingAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoaders.stopLoading();
        return;
      }

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        SFullScreenLoaders.stopLoading();
        return;
      }

      // Update user's first name & last name in the firebase firestore
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove loader
      SFullScreenLoaders.stopLoading();

      // Show success message
      SLoaders.successSnackBar(title: 'Congratulation', message: 'Your Name has been updated.');

      // Move to previous Screen
      // Get.off(()=> ProfileScreen());
    } catch (e){
      SFullScreenLoaders.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}