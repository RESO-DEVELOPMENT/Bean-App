import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/api/account_api.dart';
import '../data/models/user.dart';
import '../data/models/user_create.dart';
import '../enums/view_status.dart';
import '../utils/request.dart';
import '../utils/route_constrant.dart';
import '../utils/share_pref.dart';
import '../widget/dialog/dialog.dart';
import 'base_view_model.dart';
import 'cart_view_model.dart';
import 'startup_view_model.dart';

class AccountViewModel extends BaseViewModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  AccountAPI accountAPI = AccountAPI();
  UserModel? user;
  String? userId;
  UserDetails? memberShipModel;
  String? phoneNumber;
  var verId = '';
  int? resendTok = 0;
  var receivedID = '';
  AccountViewModel() {
    auth = FirebaseAuth.instance;
    getToken().then((value) => requestObj.setToken = value);
    getUserId().then((value) => userId = value);
  }
  Future<void> onLoginWithPhone(String phone) async {
    showLoadingDialog();
    phoneNumber = phone;
    auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          showLoadingDialog();
          await auth.signInWithCredential(credential).then((value) => {
                userCredential = value,
              });
          String? token = await auth.currentUser?.getIdToken();
          await accountAPI.signIn(token ?? '').then((value) => user = value);
          if (user == null || user?.userInfo == null) {
            showAlertDialog(
                title: 'Lỗi đăng nhập',
                content: user?.message ?? 'Đăng nhập không thành công');
            return;
          } else {
            requestObj.setToken = user?.accessToken ?? '';
            await setUserId(user?.userInfo?.id ?? '');
            await setToken(user!.accessToken ?? '');
            await getMembershipInfo(user?.userInfo?.id);
            await Get.find<CartViewModel>().getListPromotion();
            hideDialog();
            await Get.offAllNamed(RouteHandler.HOME);
          }
        } catch (e) {
          await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
          // Get.back();
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        await showAlertDialog(
            title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
        Get.back();
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (kDebugMode) {
          print(verificationId);
          print(resendToken ?? 0);
        }
        receivedID = verificationId;
        resendTok = resendToken;
        await Get.offNamed(
          RouteHandler.OTP,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verId = verificationId;
      },
    );
  }

  Future<void> resendOtp() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          showLoadingDialog();
          await auth.signInWithCredential(credential).then((value) => {
                userCredential = value,
              });
          String? token = await auth.currentUser?.getIdToken();
          await accountAPI.signIn(token ?? '').then((value) => user = value);
          if (user == null || user?.userInfo == null) {
            showAlertDialog(
                title: 'Lỗi đăng nhập',
                content: user?.message ?? 'Đăng nhập không thành công');
            return;
          } else {
            requestObj.setToken = user?.accessToken ?? '';

            await setUserId(user?.userInfo?.id ?? '');
            await setToken(user!.accessToken ?? '');
            userId = user?.userInfo?.id;
            await getMembershipInfo(user?.userInfo?.id);
            await Get.find<CartViewModel>().getListPromotion();
            hideDialog();
            await Get.offAllNamed(RouteHandler.HOME);
          }
        } catch (e) {
          await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
          // Get.back();
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        await showAlertDialog(
            title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
        Get.back();
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (kDebugMode) {
          print(verificationId);
          print(resendToken ?? 0);
        }
        receivedID = verificationId;
        resendTok = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verId = verificationId;
      },
    );
  }

  Future<void> verifyOTPCode(code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: code,
    );
    try {
      showLoadingDialog();
      await auth.signInWithCredential(credential).then((value) => {
            userCredential = value,
          });
      String? token = await auth.currentUser?.getIdToken();
      await accountAPI.signIn(token ?? '').then((value) => user = value);
      if (user == null || user?.userInfo == null) {
        showAlertDialog(
            title: 'Lỗi đăng nhập',
            content: user?.message ?? 'Đăng nhập không thành công');
        return;
      } else {
        requestObj.setToken = user?.accessToken ?? '';
        await setUserId(user?.userInfo?.id ?? '');
        await setToken(user!.accessToken ?? '');
        await getMembershipInfo(user?.userInfo?.id);
        await Get.find<CartViewModel>().getListPromotion();
        hideDialog();
        await Get.offAllNamed(RouteHandler.HOME);
      }
    } catch (e) {
      await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
      // Get.back();
    }
  }

  Future<void> getMembershipInfo(String? userId) async {
    try {
      setState(ViewStatus.Loading);
      await accountAPI
          .getUserById(userId ?? '')
          .then((value) => memberShipModel = value);

      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi", content: e.toString());
    }
  }

  Future<String?> getQRCode() async {
    try {
      setState(ViewStatus.Loading);
      String? qr;

      await accountAPI.getUserQRCode(userId ?? '').then((value) => qr = value);

      setState(ViewStatus.Completed);
      return qr;
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi", content: e.toString());
      return null;
    }
  }

  Future<void> processSignOut() async {
    var option = await showConfirmDialog();
    if (option == true) {
      showLoadingDialog();
      user = null;
      userId = null;
      memberShipModel = null;
      await auth.signOut();
      await removeALL();
      await Get.find<StartUpViewModel>().handleStartUpLogic();
      hideDialog();
    }
  }

  Future<void> updateUser(UserUpdate user, String id) async {
    showLoadingDialog();
    var res = await accountAPI.updateUser(id, user);
    memberShipModel = await accountAPI.getUserById(id);
    hideDialog();
    await showAlertDialog(content: res);
  }
}
