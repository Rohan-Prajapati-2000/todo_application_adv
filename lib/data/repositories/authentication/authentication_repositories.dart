import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/features/todo/screen/home_screen/home_screen.dart';
import 'package:todo_app/utils/exceptions/firebase_exceptions.dart';

import '../../../features/authentication/screen/login/login_screen.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authentication User Data
  User? get authUser => _auth.currentUser;

  /// called from main.dart on app launch
  @override
  void onReady() {
    /// remove the native splash screen
    FlutterNativeSplash.remove();

    /// Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }


  // Method to get the current user ID
  String getCurrentUserId() {
    // Implement logic to retrieve the current user's ID
    // For example, using FirebaseAuth
    return FirebaseAuth.instance.currentUser!.uid;
  }


/*----------------------------Email & Password Sign in---------------------------------*/

  /// [EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  /// [EmailVerification] - Mail Verification
  // Future<void> sendEmailVerification() async {
  //   try {
  //     await _auth.currentUser?.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     throw SFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw SFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const SFormatException();
  //   } on PlatformException catch (e) {
  //     throw SPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  /// [ReAuthentication] - ReAuthenticate User
  // Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
  //   try {
  //     // Create a credential
  //     AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
  //
  //     // Re-Authenticate
  //     await _auth.currentUser!.reauthenticateWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     throw SFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw SFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const SFormatException();
  //   } on PlatformException catch (e) {
  //     throw SPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  /// [EmailAuthentication] - Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

/*----------------------------Federated identify & social sign-in---------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  // Future<UserCredential> signInWithGoogle() async {
  //   try {
  //     /// Trigger the authentication flow
  //     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
  //
  //     /// obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
  //
  //     // Create new credential
  //     final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
  //
  //     // Once Signed in, return the UserCredential
  //     return await _auth.signInWithCredential(credentials);
  //
  //   } on FirebaseAuthException catch (e) {
  //     throw SFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw SFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const SFormatException();
  //   } on PlatformException catch (e) {
  //     throw SPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  /// [FacebookAuthentication] - FACEBOOK

/*----------------------------./end Federated identify & social sign-in---------------------------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove user Auth and Firestore Account
//   Future<void> deleteAccount() async {
//     try {
//       await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//       await _auth.currentUser?.delete();
//     } on FirebaseAuthException catch (e) {
//       throw SFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw SFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const SFormatException();
//     } on PlatformException catch (e) {
//       throw SPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again';
//     }
//   }
}
