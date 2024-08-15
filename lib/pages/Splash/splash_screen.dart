import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/common/constants/constant.dart';
import 'package:flutter_login/routes/app_routes.dart';
import 'package:flutter_login/block/ Splash/splash_block.dart';
import 'package:flutter_login/block/ Splash/splash_event.dart';
import 'package:flutter_login/block/ Splash/splash_state.dart';
class SplashScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashBloc()..add(GetConfiguration()),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is ConfigurationLoading) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamedAndRemoveUntil( state.page=="login"?AppRoutes.loginScreen  : AppRoutes.homeScreen , (Route route) => false);
              });
            }
            if (state is ConfigurationLoaded) {

             }
            if (state is ConfigurationLoadedError) {

             }
          },
          child: Stack(
            children: [
              Center(
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
              child:  Image.asset('assets/images/logo.png'),

          )

              ),
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Text(
                  '© 2024 ProgressSoft',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
