import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import 'package:crypto/crypto.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _firebaseAuth;

  RegisterBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(const InitialState()) {
    on<TogglePasswordVisibility>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(
            isPasswordVisible: !currentState.isPasswordVisible));
      }
    });

    on<ToggleConfirmPasswordVisibility>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(
            isConfirmPasswordVisible: !currentState.isConfirmPasswordVisible));
      }
    });

    on<UpdateGender>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(gender: event.gender));
      }
    });

    on<UpdateAge>((event, emit) {
      if (state is InitialState) {
        final currentState = state as InitialState;
        emit(currentState.copyWith(age: event.age));
      }
    });
    on<SendOtpEvent>((event, emit) async {
      await _sendOtp(event, emit).then((res) {
        print("SendOtpEvent");
        print(res);
        if (res.contains("codeSent")) {
          var verificationId = res.split(",")[1];

          emit(AuthOtpSent(verificationId));
        }
        else if (res == "verificationCompleted") {

        }
        else if (res == "codeAutoRetrievalTimeout") {

        }
        else {
          emit(AuthError(res));
        }
      });
    });
    on<SaveUserEvent>((event, emit) async {
      await _saveUser(event, emit).then((res) {
        if(res.contains("User Added")){


          emit(RegisterSuccess());
        }
        else {
          emit(AuthError(res  ));
        }
      });
    });
  }


  Future<String> _saveUser(SaveUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    Completer<String> completer = Completer();
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      // Check if the phone number already exists
      QuerySnapshot querySnapshot = await users.where('phone', isEqualTo: event.phoneNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Phone number already found, emit an error state
        emit(RegisterFailure('This phone number is already registered. Please sign in.'));
        completer.complete('This phone number is already registered. Please sign in.');
        return completer.future;
      }
      String userId = Uuid().v4();
      final bytes = utf8.encode(event.password); // Convert password to bytes
      final digest = sha256.convert(bytes); // Hash the password using SHA-256

      await users.doc(userId).set({
        'name': event.name,
        'phone': event.phoneNumber,
        'age': event.age,
        'gender': event.gender,
        "pass":digest.toString(),
        'createdAt': FieldValue.serverTimestamp(), // Automatically generates a timestamp
      });
      completer.complete('User Added');
      return completer.future;

    } catch (e) {
      emit(RegisterFailure('An error occurred while sending the OTP: $e'));
      completer.complete('An error occurred while sending the OTP: $e');
      return completer.future;

    }
  }

  Future<String> _sendOtp(SendOtpEvent event, Emitter<RegisterState> emit) async {
    emit(AuthLoading());
    Completer<String> completer = Completer();
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      // Check if the phone number already exists
      QuerySnapshot querySnapshot = await users.where('phone', isEqualTo: event.phoneNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Phone number already found, emit an error state
        emit(RegisterFailure('This phone number is already registered. Please sign in.'));
        completer.complete('This phone number is already registered. Please sign in.');
        return completer.future;
      }
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verificationCompleted");
          completer.complete("verificationCompleted");
          // emit(AuthVerified());
        },
        verificationFailed: (FirebaseAuthException e) {
          print("verificationFailed");
          emit(AuthError(e.message ?? 'Verification failed.'));
          completer.completeError(e.message ?? 'Verification failed.');

        },
        codeSent: (String verificationId, int? resendToken) {
          print("codeSent");
          completer.complete("codeSent,$verificationId");
          // emit(AuthOtpSent());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout");
          completer.complete("codeAutoRetrievalTimeout");
        },
      );
      return completer.future;

    } catch (e) {
       emit(AuthError('An error occurred while sending the OTP: $e'));
      completer.complete('An error occurred while sending the OTP: $e');
      return completer.future;

    }
  }
}
