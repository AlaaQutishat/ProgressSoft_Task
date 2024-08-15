import 'package:flutter/material.dart';
import 'package:flutter_login/block/Home/home_block.dart';
import 'package:flutter_login/block/Login/login_block.dart';
import 'package:flutter_login/block/Otp/otp_block.dart';
import 'package:flutter_login/block/register/register_block.dart';
import 'package:flutter_login/data/apiClient/api_client.dart';
import 'package:flutter_login/pages/Home/home_screen.dart';
import 'package:flutter_login/pages/Splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/block/ Splash/splash_block.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import '../../firebase_options.dart';

import 'routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'progresssoft',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {

    runApp(
        MultiBlocProvider(

          providers: [
            BlocProvider<SplashBloc>(
              create: (BuildContext context) => SplashBloc( ),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc( ),
            ),
            BlocProvider<RegisterBloc>(
              create: (BuildContext context) => RegisterBloc(firebaseAuth: FirebaseAuth.instance ),
            ),
            BlocProvider<OtpBloc>(
              create: (BuildContext context) => OtpBloc(firebaseAuth: FirebaseAuth.instance ),
            ),
            BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(ApiClient(appBaseUrl: "https://jsonplaceholder.typicode.com/") ),
            ),

          ],
          child:MaterialApp(
            initialRoute: AppRoutes.initialRoute,
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            home:   SplashScreen( ),

          ),
        ));
  });
}
