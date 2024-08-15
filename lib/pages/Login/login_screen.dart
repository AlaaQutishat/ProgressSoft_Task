import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../block/Login/login_block.dart';
import '../../block/Login/login_event.dart';
import '../../block/Login/login_state.dart';
import '../../common/constants/constant.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/validation_functions.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:   Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(AppRoutes.registerScreen);

            },
            child: const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: MediaQuery.of(context).size.width * .8,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        if (state is PasswordState) {
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
                              BlocProvider.of<LoginBloc>(context).add(TogglePasswordVisibility());
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
                    BlocListener<LoginBloc, LoginState>(
                      listener: (BuildContext context,  state) async {
                        if(state is LoginSuccess){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn' , true);
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homeScreen, (Route route) => false);

                        }
                        else if(state is LoginFailure){
                          if(state.error=="User_Not_Found"){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:   Text('${AppConstants.configration["user-not-found"]}'),
                                  content: const Text('The phone number does not exist. Would you like to register?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Dismiss the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Dismiss the dialog
                                        Navigator.of(context).pushNamed(AppRoutes.registerScreen);

                                      },
                                      child: const Text('Register'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          else  if(state.error=="Invalid_password"){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${AppConstants.configration["password_incorrect"]}')),
                            );
                          }
                          else{

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
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
                        text: "Login",
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(LoginSubmitted( "+${AppConstants.configration["country_code"]??"962"}${phoneController.text}" , passwordController.text));
                          }
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
    );
  }
}
