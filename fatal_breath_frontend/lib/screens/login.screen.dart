import 'package:fatal_breath_frontend/screens/signup.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String err = "";
  bool successful = true;

  //Inputs validation
  void validate() => _form.currentState?.validate();

  loginPressed() {
    // ignore: avoid_print
    print('login');
  }

  emailvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter the email";
    }
    if (!value.contains("@")) {
      return "Please enter a valid email";
    }
    return null;
  }

  passwordvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (value.length < 6) {
      return "Should be minimum 10 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/light_icon.png',
                scale: 6,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FATAL ',
                      style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'BREATH',
                      style: TextStyle(
                        color: HexColor('#1424B9'),
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextForm(
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter your Email',
                        isPass: false,
                        validator: emailvalidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextForm(
                        controller: passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.text,
                        isPass: true,
                        label: 'Enter your Password',
                        validator: passwordvalidator,
                      ),
                    ],
                  )),

              const SizedBox(
                height: 40,
              ),
              ButtonGlobal(
                text: 'Sign In',
                color: '091479',
                onBtnPressed: () => loginPressed(),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'Or',
              //   style: GoogleFonts.poppins(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w400,
              //     color: Colors.grey[600],
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ButtonGlobal(
              //   text: 'Sign In With Google',
              //   color: '0047FF',
              //   onBtnPressed: () => loginPressed(),
              // ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an Account?',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
            InkWell(
              child: Text(
                ' Sign Up',
                style: GoogleFonts.poppins(color: HexColor('#0047FF')),
              ),
              onTap: () {
                Get.to(const SignUpScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
