import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final FirebaseAuth _firebaseAuth;

  OtpBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(const InitialState()) {
    on<UpdateOtp>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(otp: currentState.otp ,verifyId:currentState.verifyId));
      }
    });
    on<UpdateVerifyId>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(otp: currentState.otp ,verifyId:currentState.verifyId ));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      await _verifyOtp(event, emit).then((res) {
        if (res == "verificationCompleted") {
          emit(AuthVerified());
        }

        else {
          emit(AuthError(res));
        }
      });
    });
  }

  Future<String> _verifyOtp(VerifyOtpEvent event,
      Emitter<OtpState> emit) async {
    emit(AuthLoading());
    Completer<String> completer = Completer();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verifyId,
        smsCode: event.otp,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if(user!=null){
        completer.complete("verificationCompleted");
      }
      else{
        completer.complete("Something Wrong , User Not Verified");
      }

      return completer.future;
    } catch (e) {

      String errorMessage;
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          errorMessage = 'The OTP you entered is incorrect. Please try again.';
        } else {
          errorMessage = 'An error occurred: ${e.message}';
        }
      } else {
        errorMessage = 'An unknown error occurred. Please try again.';
      }


      emit(AuthError(errorMessage));
      completer.completeError(errorMessage);

      return "";
    }

  }
}