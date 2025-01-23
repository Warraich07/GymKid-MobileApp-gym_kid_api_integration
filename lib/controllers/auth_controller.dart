import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/general_controller.dart';
import 'package:gym_kid/models/main_user_model.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../components/page_navigation.dart';
import '../helper/custom_dialogbox.dart';
import '../helper/shared_preference.dart';
import '../models/edit_profile.dart';
import '../views/auth/forgot_passoword/change_password.dart';
import '../views/auth/forgot_passoword/otp_screen.dart';
import '../views/auth/login.dart';
import '../views/auth/signup/reason.dart';
import '../views/navbar/bottom_nav_bar.dart';
import 'base_controller.dart';

class AuthController extends GetxController {
  final AuthPreference _authPreference = AuthPreference.instance;
  // RxInt userType = 0.obs;
  // String homeOwnerLat = "31.4504";
  // String? homeOwnerLong = "73.1350";
  // String? uploadImageUrlServiceProvider;
  // String? uploadImageUrlHomeOwner;
  // File? uploadImageFileServiceProvider;
  // File? uploadImageFileCustomer;
  // XFile? pickedImage;
  // BaseController _baseController = BaseController.instance;
  // RxString token = "".obs;
  // RxString fcmToken = ''.obs;
  Rxn<MainUserModel> userData=Rxn<MainUserModel>();
  RxList<EditProfileModel> editProfileData=<EditProfileModel>[].obs;

  // RxString token=''.obs;
  GeneralController _generalController=Get.find();
  BaseController _baseController = BaseController.instance;
  RxString imagePath=''.obs;
  RxString imagePathForSignUp=''.obs;
  RxString token = "".obs;
  RxString fcmToken = ''.obs;
  RxInt userType = 0.obs;
  String homeOwnerLat = "31.4504";
  String? homeOwnerLong = "73.1350";
  String? uploadImageUrlServiceProvider;
  String? uploadImageUrlHomeOwner;
  File? uploadImageFileServiceProvider;
  File? uploadImageFileCustomer;
  final picker = ImagePicker();
  XFile? pickedImage;
  RxString otpCode="".obs;
  RxString accessToken = "".obs;
  RxString verifiedOtp=''.obs;
  RxString verifiedEmail=''.obs;
  RxBool isAdminView=false.obs;
  RxInt userID = 0.obs;
  RxInt completeProfileUserID = 0.obs;
  RxString selectedReason="".obs;
  RxString selectedGoal="".obs;
  RxString isGoesToGym="".obs;
  RxInt selectedAge=12.obs;
  RxString selectedGender="".obs;

  Future editProfile(String name,String email,String age,String gender) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'name': name,
      'email': email,
      'age': age,
      'gender': gender
    };
    var response = await DataApiService.instance
        .multiPartImage('/edit-profile',[imagePath.value.isEmpty?null:imagePath.value],"image",body)
        // .post('/edit-profile',body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");

    var result = json.decode(response);
    print(result['success'].toString()+" is status");
    if (result['success']) {
      Get.back();
      _generalController.onBottomBarTapped(0);
      // please uncomment it
      // userData.value=MainUserModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      editProfileData.value = List<EditProfileModel>.from(
          result['data'].map((x) => EditProfileModel.fromJson(x)));
      userData.value!.name=editProfileData.first.name;
      userData.value!.email=editProfileData.first.email;
      userData.value!.age=editProfileData.first.age;
      userData.value!.gender=editProfileData.first.gender;
      userData.value!.image=editProfileData.first.image;
      _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));

      PageTransition.pageProperNavigation(page: CustomBottomNavBar());

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future changePassword(String password,String confirmPassword) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': verifiedEmail.value,
      'password': password,
      'password_confirmation': confirmPassword
    };
    var response = await DataApiService.instance
        .post('/reset-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // please uncomment it
      // userData.value=MainUserModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      Get.offAll(() => Login());
      CustomDialog.showProfileCompleteDialog(description: "Password changed successfully");

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future createNewPassword(String oldPassword,String newPassword,String confirmNewPassword) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': confirmNewPassword
    };
    var response = await DataApiService.instance
        .post('/change-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // please uncomment it
      // userData.value=MainUserModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      Get.offAll(() => Login());


    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future verifyOtp() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': verifiedEmail.value,
      'otp': otpCode.value
    };
    var response = await DataApiService.instance
        .post('/verify-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // please uncomment it
      // userData.value=MainUserModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      Get.to(() => ChangePassword());


    } else {
      if(result['message']=="Incorrect otp"){
        CustomDialog.showErrorDialog(description: "Invalid OTP");
      }else if(result['message']=="otp is required"){
        CustomDialog.showErrorDialog(description: 'Enter OTP');

      }
      else{
        CustomDialog.showErrorDialog(description: result['message']);

      }
    }
  }

  Future loginUser(String email,String password) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email,
      'password': password
    };
    var response = await DataApiService.instance
        .post('/login', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // please uncomment it
      _authPreference.setUserLoggedIn(true);
      userData.value=MainUserModel.fromJson(result['data']);
      accessToken.value=result['token'];
      print(accessToken.value+"token is this");
      _authPreference.saveUserDataToken(token: accessToken.value);
      _authPreference.setUserLoggedIn(true);
      _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      PageTransition.pageProperNavigation(page: CustomBottomNavBar());


    } else {
      // userID.value=result['data']['id'].toString();
      // _authPreference.setUserIdInCache(result['data']['id'].toString());
      if(result['message']=='Please complete profile before login'){
        userID.value=result['data']['id'];

        CustomDialog.showErrorDialog(
          buttonText: "Complete Profile",
            onTap: (){
              Get.to(() => const Reason(), transition: Transition.rightToLeftWithFade);
            },
            description: result['message']);
      }else{
        CustomDialog.showErrorDialog(description: result['message']);
      }
    }
  }

  Future completeProfile() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'user_id': userID.value.toString(),
      'reason': selectedReason.value,
      'goals': selectedGoal.value,
      'gym': isGoesToGym.value,
      'age': selectedAge.value.toString(),
      'gender': selectedGender.value
    };
    var response = await DataApiService.instance
        .post('/profile', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      print("profile completed");
      CustomDialog.showProfileCompleteDialog(description: "Profile Completed",
      onTap: (){
        Get.to(() => const Login(), transition: Transition.zoom);
      }
      );

      // please uncomment it
      // userData.value=SignUpModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.data.toJson()));
      // userID.value=result['data']['id'];
      // Get.to(() => const Reason(), transition: Transition.rightToLeftWithFade);

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  saveOtp(String otp){
    otpCode.value=otp;
  }

  updateSelectedGender(String gender){
    selectedGender.value=gender;
  }

  updateSelectedAge(int age){
    selectedAge.value=age;
  }

  updateGymGoingStatus(String value){
    isGoesToGym.value=value;
  }

  updateGoal(String goal){
    selectedGoal.value=goal;
  }

  updateSelectedReason(String reason){
    selectedReason.value=reason;
  }

  updateOtpCode(String otp){
    otpCode.value=otp;
  }


  Future signUp(String userName,String email,String password) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'username': userName,
      'email': email,
      'password': password
    };

    var response = await DataApiService.instance
        .multiPartImage('/signup',[imagePathForSignUp.value.isEmpty?null:imagePathForSignUp.value],"image",body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // please uncomment it
      // userData.value=SignUpModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.data.toJson()));
      userID.value=result['data']['id'];
      _authPreference.setUserIdInCache(result['data']['id'].toString());
      Get.to(() => const Reason(), transition: Transition.rightToLeftWithFade);

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  // Future resetPassword(String password,String confirmPassword,String email) async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     'email': 'admin@admin.com',
  //     'password': password,
  //     'password_confirmation': confirmPassword,
  //     'otp': verifiedOtp.value.toString()
  //   };
  //   var response = await DataApiService.instance
  //       .Auth('auth/password/reset', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     }
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   // print(result['success'])
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // please uncomment it
  //     Get.offAll(() => LogInScreen());
  //
  //     //
  //     // userData.value=MainUserModel.fromJson(result['data']);
  //     // accessToken.value=result['token'];
  //     // print(accessToken.value+"token is this");
  //     // _authPreference.saveUserDataToken(token: accessToken.value);
  //     // _authPreference.setUserLoggedIn(true);
  //     // _authPreference.saveUserData(token: jsonEncode(userData.value!.data.toJson()));
  //     // Get.offAll(() => HomeScreen());
  //
  //   } else {
  //     CustomDialog.showErrorDialog(description: result['message']);
  //   }
  // }
  //
  Future sendOtpCode(String email) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email,
    };
    var response = await DataApiService.instance
        .Auth('/forgot-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {

      // please uncomment it
      print(result['data']['otp']);
      // CustomDialog.showErrorDialog(description: result['data']['otp']);
      verifiedOtp.value=result['data']['otp'].toString();
      verifiedEmail.value=email;
      Future.delayed(Duration(seconds: 2), () {
        Get.snackbar(
          'OTP',
          result['data']['otp'].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.buttonColor, // Background color
          colorText: Colors.black, // Text color for better visibility
        );
      });
      Get.to(() => OtpVerification());
      //
      // userData.value=MainUserModel.fromJson(result['data']);
      // accessToken.value=result['token'];
      // print(accessToken.value+"token is this");
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true);
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.data.toJson()));
      // Get.offAll(() => HomeScreen());

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future deleteAccount() async {
    _baseController.showLoading();
    var response = await DataApiService.instance
        .post('/delete-account', {})
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      _authPreference.setUserLoggedIn(false);
      PageTransition.pageProperNavigation(page: const Login());
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  // Future loginUserForAdminAccess(String email,String password) async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     'email': email,
  //     'password':password,
  //   };
  //   var response = await DataApiService.instance
  //       .Auth('auth/login', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     }
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   // print(result['success'])
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // please uncomment it
  //     isAdminView.value=true;
  //     userData.value=MainUserModel.fromJson(result['data']);
  //     accessToken.value=result['token'];
  //     print(accessToken.value+"token is this");
  //     _authPreference.saveUserDataToken(token: accessToken.value);
  //     _authPreference.setUserLoggedIn(true);
  //     _authPreference.saveUserData(token: jsonEncode(userData.value!.data.toJson()));
  //     Get.back();
  //
  //   } else {
  //     CustomDialog.showErrorDialog(description: result['message']);
  //   }
  // }
  // Future logoutUser() async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     'email': "admin@admin.com",
  //   };
  //   var response = await DataApiService.instance
  //       .Auth('auth/logout', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     }
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // please uncomment it
  //     // barberData.value=BarbersModel.fromJson(result['data']);
  //     _authPreference.setUserLoggedIn(false);
  //     Get.offAll(()=> LogInScreen());
  //     // _authPreference.saveUserData(token: jsonEncode(barberData.value!.toJson()));
  //     //   Get.offAll(() => BarberBottomNavBar());
  //
  //   } else {
  //     CustomDialog.showErrorDialog(description: result['message']);
  //   }
  // }
  //
  // Future sendForgetPasswordCode(String email) async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     'email': email,
  //   };
  //   var response = await DataApiService.instance
  //       .post('forgot-password', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {}
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // please uncomment this code
  //     // userEmail.value=email;
  //     // print("password reset code send to your email");
  //     // HapticFeedback.heavyImpact();
  //     // Get.to(() => VerifyOTP(email: '',fromSignUp: false,isUser: true,),
  //     //   transition: Transition.rightToLeft,
  //     // );
  //   } else {
  //     String errorMessages = result['message'];
  //     CustomDialog.showErrorDialog(description: errorMessages);
  //   }
  // }
  //
  // Future verifyForgetPasswordCode() async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     // please uncomment this code
  //     // 'otp': verifyOtp.value,
  //     // 'email': userEmail.value,
  //   };
  //   var response = await DataApiService.instance
  //       .post('verify-forgot-password', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {}
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // please uncomment this code
  //     // print("OTP Verified");
  //     // HapticFeedback.heavyImpact();
  //     // Get.to(()=>ResetPassword(email: userEmail.value,isUser: true,));
  //   } else {
  //     String errorMessages = result['message'];
  //     CustomDialog.showErrorDialog(description: errorMessages);
  //   }
  // }
  //
  // Future uploadProfileImage(String inputSource, from) async {
  //   try {
  //     pickedImage = await picker.pickImage(
  //         source: inputSource == 'camera'
  //             ? ImageSource.camera
  //             : ImageSource.gallery,
  //         maxWidth: 1920);
  //     if (from == "HomeOwner") {
  //       uploadImageFileCustomer = File(pickedImage!.path);
  //       uploadImageUrlHomeOwner = pickedImage!.path;
  //     } else {
  //       uploadImageFileServiceProvider = File(pickedImage!.path);
  //       uploadImageUrlServiceProvider = pickedImage!.path;
  //     }
  //   } catch (err) {
  //     Get.back();
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //   }
  // }
  void updateImagePath(String path){
    imagePath.value=path;
  }

  void updateImagePathForSignUp(String path){
    imagePathForSignUp.value=path;
  }
}
