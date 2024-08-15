import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(PasswordState(false)) {
    // Register the event handler for TogglePasswordVisibility
    on<TogglePasswordVisibility>((event, emit) {
      if (state is PasswordState) {
        final currentState = state as PasswordState;
        emit(PasswordState(!currentState.isPasswordVisible));
      }
    });

    // Register the event handler for LoginSubmitted
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      // Reference to the 'users' collection in Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      try {

        // Query to find the user by phone number
        QuerySnapshot userQuery = await users.where('phone', isEqualTo: event.username).get();

        if (userQuery.docs.isEmpty) {
          // User not found, show dialog to register
          emit(const LoginFailure("User_Not_Found"));

        }
        else {
          // User found, check password
          DocumentSnapshot userDoc = userQuery.docs.first;
          String storedPassword = userDoc['pass']; // Assume 'password' field exists
          final bytes = utf8.encode(event.password); // Convert password to bytes
          final digest = sha256.convert(bytes); // Hash the password using SHA-256
          if (storedPassword == digest.toString()) {
            emit(LoginSuccess());
          } else {
            // Password is incorrect, show error message
            emit(const LoginFailure("Invalid_password"));
          }
        }
      } catch (e) {
        emit(  LoginFailure("$e. Please try again."));
      }

    });
  }
}
