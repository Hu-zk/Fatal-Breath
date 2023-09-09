import 'dart:io';

import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/screens/signup.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

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

  Future loginPressed(email, password, context) async {
    try {
      setState(() {
        err = "";
      });
      validate();

      if (_form.currentState?.validate() == false) {
        return err = "Fill the inputs correctly";
      }

      await Provider.of<AuthProviders>(context, listen: false)
          .login(email, password, context);
      String? userId =
          Provider.of<AuthProviders>(context, listen: false).getUserId;

      if (userId != null) {
        Get.to(const SignUpScreen());
      }
    } on HttpException catch (error) {
      setState(() {
        err = error.message;
        successful = true;
      });
    }
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
      return "Should be minimum 6 characters";
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
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/light_icon.png',
                scale: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FATAL',
                    style: TextStyle(
                      color: GlobalColors.textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'BREATH',
                    style: TextStyle(
                      color: HexColor('#1424B9'),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
                        textInputType: TextInputType.text,
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter your Password',
                        isPass: true,
                        validator: passwordvalidator,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              ButtonGlobal(
                text: 'Sign In',
                color: '091479',
                onBtnPressed: () {
                  setState(() {
                    successful = false;
                  });
                  loginPressed(
                      emailController.text, passwordController.text, context);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                err,
                style: GoogleFonts.poppins(
                  color: GlobalColors.errColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
