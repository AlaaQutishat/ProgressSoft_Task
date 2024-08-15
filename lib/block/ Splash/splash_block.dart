import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/block/ Splash/splash_event.dart';
import 'package:flutter_login/block/ Splash/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constants/constant.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc( ) : super(const ConfigurationLoaded()) {
    on<GetConfiguration>(_GetConfiguration);
  }


  Future<void> _GetConfiguration(GetConfiguration event, Emitter<SplashState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn')??false;
    if(isLoggedIn){
      emit(const ConfigurationLoading("home"));
    }
    else{
      emit(const ConfigurationLoading("login"));
    }
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('application').doc('setting').get();
      AppConstants.configration = snapshot.data()!;
      emit(ConfigurationLoaded(config: snapshot.data() ?? {} ));
    } catch (e) {
      emit(ConfigurationLoadedError('Failed to load configuration : $e'));
    }
  }
}