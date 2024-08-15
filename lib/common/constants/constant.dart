import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class AppConstants {
  static String ApiURL = "https://edusphereai.com/APIs/Student/";
  static const String TOKEN = 'User_token';
  static const String USER_ID = 'User_Id';
  static const String SAVE_LOGIN = 'Save_login';
  static const String LANGUAGE_CODE = 'language_code';

  static Map<String, dynamic> configration ={};











  static showEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..boxShadow = <BoxShadow>[]
      ..indicatorWidget = const SpinKitCircle(
        color: Colors.white,
        duration: Duration(milliseconds: 1000),
        size: 50.0,
      )
      ..dismissOnTap = false
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = const Color(0xff031630).withOpacity(0.8432);
    EasyLoading.show();
  }


}


