import 'package:flutter/material.dart';
 import 'package:flutter_login/block/Home/home_block.dart';
import 'package:flutter_login/block/Home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/block/Otp/otp_block.dart';
import 'package:flutter_login/block/Otp/otp_event.dart';
import 'package:flutter_login/block/Otp/otp_state.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../block/Home/home_event.dart';
import '../../core/utils/color_constant.dart';
import '../../widgets/custom_elevated_button.dart';


class OtpScreen extends StatelessWidget {

TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final verificationId = arguments['verificationId'] as String;

    // Assuming you have an instance of the RegisterBloc available
    context.read<OtpBloc>().add(UpdateVerifyId(verificationId));
    return Scaffold(
appBar: AppBar(title: const Text("Enter Otp"),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),

              showFieldAsBox: true,

              onCodeChanged: (String code) {

              },

              onSubmit: (String verificationCode){
                otpController.text = verificationCode;
                BlocProvider.of<OtpBloc>(context).add(
                  UpdateOtp(  otpController.text),
                );
              }, // end onSubmit
            ),
            const SizedBox(height: 40),
            BlocListener<OtpBloc, OtpState>(
              listener: (BuildContext context,  state) {

                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Phone Verified")),
                  );
                  Navigator.of(context).pop("1");

                }
              },
              child: CustomElevatedButton(
                height: 60,
                buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    ColorConstant.primaryColor.withOpacity(0.6),
                  ),
                ),
                text: "Verify",
                margin: const EdgeInsets.symmetric(horizontal: 50),
                onPressed: () {
                    BlocProvider.of<OtpBloc>(context).add(
                      VerifyOtpEvent(otpController.text,verificationId),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
