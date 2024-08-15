import 'dart:ffi';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/block/register/register_block.dart';
import 'package:flutter_login/block/register/register_state.dart';
   import '../../block/register/register_event.dart';
import '../../common/constants/constant.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/validation_functions.dart';
import '../../routes/app_routes.dart';
import '../../widgets/AgePickerDialog.dart';
import '../../widgets/CustomDropdown.dart';
import '../../widgets/CustomeDropDownIos.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '';
class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Signup"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: userNameController,
                        context: context,
                        textInputAction: TextInputAction.next,
          
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter Valid Full Name";
                          }
                          return null;
                        },
                        labelText: "Full Name",
                      ),
                      const SizedBox(height: 20),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextFormField(
                          controller: phoneController,
                          context: context,
                          isPhone: true,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          prefix: SizedBox(
                            width: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                        "+${AppConstants.configration["country_code"]??"962"}",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                (!isValidPhone(value, isRequired: true))) {
                              return "Enter Valid Phone Number";
                            }
                            return null;
                          },
                          labelText: "phoneNumber",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Text('Gender:'),
                        ],
                      ),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          String dropdownValue = 'Male';
                          if (state is InitialState) {
                            dropdownValue = state.gender;
                          }
                          return
          
                             Platform.isAndroid
                                ? CustomDropdown(
                              opacity: -1,
                              width: MediaQuery.of(context).size.width,
                              hint: "Select Gender",
                               value:   dropdownValue,
                              dropdownItems: {
                                for (var v in {"0":'Male', "1":'Female'}.entries)
                                  v.key.toString().trim():
                                   v.value.toString().trim()
                              },
                              onChanged: (value) {
                                context.read<RegisterBloc>().add(UpdateGender(value));
                              },
                            )
                                : CustomDropdownIos(
                               width: MediaQuery.of(context).size.width,
                              hint: "",
          
                              value: dropdownValue == ""
                                  ? "Select Gender"
                                  : dropdownValue,
                              dropdownItems: {
                                for (var v in {"0":'Male', "1":'Female'}.entries)
                                  v.key.toString():  v.value.toString().trim()
                              },
                              onChanged: (value) {
          
                              },
                              onConfirm: (value) {
          
                                context.read<RegisterBloc>().add(UpdateGender({"0":'Male', "1":'Female'}.values.toList()[value] ));
          
                              },
                            );
          
          
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          int age = 18;
                          if (state is InitialState) {
                            age = state.age;
                          }
                          return
                            TextField(
                              controller: TextEditingController(text: age.toString()),
                              readOnly: true,
                              onTap: () async {
                                final newAge = await showDialog<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AgePickerDialog(initialAge: age);
                                  },
                                );
                                if (newAge != null) {
                                  context.read<RegisterBloc>().add(UpdateAge(newAge));
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Age',
                              ),
                            );
                        },
                      ),
          
                      const SizedBox(height: 20),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          bool isPasswordVisible = false;
                          if (state is InitialState) {
                            isPasswordVisible = state.isPasswordVisible;
                          }
                          return CustomTextFormField(
                            controller: passwordController,
                            context: context,
                            labelText: "Password",
                            obscureText: !isPasswordVisible,
                            suffix: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                BlocProvider.of<RegisterBloc>(context).add(TogglePasswordVisibility(isPasswordVisible));
          
                                },
                            ),
                            validator: (value) {
                              if (value == null ||
                                  (!isValidPassword(value, isRequired: true))) {
                                return "Password Must be at least 8 digits,\ncontain at least 1 Capital, 1 Small, and 1 symbol character.";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
          
                          bool isConfirmPasswordVisible = false;
                          if (state is InitialState) {
                            isConfirmPasswordVisible = state.isConfirmPasswordVisible;
                          }
          
                          return CustomTextFormField(
                            controller: confirmPasswordController,
                            context: context,
                            labelText: "Confirm Password",
                            obscureText: !isConfirmPasswordVisible,
                            suffix: IconButton(
                              icon: Icon(isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                BlocProvider.of<RegisterBloc>(context).add(  ToggleConfirmPasswordVisibility(isConfirmPasswordVisible));
                              },
                            ),
                            validator: (value) {
                              if (value == null ||
                                  (!isValidPassword(value, isRequired: true))) {
                                return "Password Must be at least 8 digits,\ncontain at least 1 Capital, 1 Small, and 1 symbol character.";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      BlocListener<RegisterBloc, RegisterState>(
                        listener: (BuildContext context,  state) async {
          
                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }

                          if (state is RegisterLoading) {
                          AppConstants.showEasyLoading();
                          }
                          if (state is RegisterSuccess) {
                            EasyLoading.dismiss();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("User Created Successfully , You can log in now")),
                            );
                            // Navigate to the login screen
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen, (Route route) => false);

                            });
                          }
                          else if (state is AuthOtpSent) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Otp Sent')),
                            );
                           var res = await Navigator.of(context).pushNamed(AppRoutes.otpScreen, arguments: {
                            'verificationId': state.verificationId,
                            },);
                           if(res=="1"){
                             BlocProvider.of<RegisterBloc>(context).add(
                               SaveUserEvent(
                                 "+${AppConstants.configration["country_code"] ?? "962"}${phoneController.text}",
                                 userNameController.text,
                                 state.age.toString(),
                                 passwordController.text,
                                 state.gender,
                               ),
                             );
                           }
          
                          }
                        },
                        child: CustomElevatedButton(
                          height: 60,
                          buttonStyle: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstant.primaryColor.withOpacity(0.6),
                            ),
                          ),
                          text: "Register",
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
          
                              BlocProvider.of<RegisterBloc>(context).add(
                                SendOtpEvent("+${AppConstants.configration["country_code"]??"962"}${phoneController.text}"),
                              );                          }
                          },
                        ),
                      ),
          
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
