import 'package:flutter/material.dart';
import 'package:flutter_login/pages/Home/home_screen.dart';
import 'package:flutter_login/pages/Otp/otp_screen.dart';
import 'package:flutter_login/pages/Register/register_screen.dart';
import 'package:flutter_login/pages/Splash/splash_screen.dart';
import 'package:flutter_login/pages/Login/login_screen.dart';

class AppRoutes {


  static const String loginScreen = '/login_screen';
  static const String initialRoute = '/initialRoute';
  static const String registerScreen = '/register_screen';
  static const String homeScreen = '/home_screen';
  static const String otpScreen = '/otp_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    initialRoute: (context) =>  SplashScreen(),
    registerScreen: (context) => RegisterScreen(),
    homeScreen: (context) => HomeScreen(),
    otpScreen: (context) => OtpScreen(),
  };
}
