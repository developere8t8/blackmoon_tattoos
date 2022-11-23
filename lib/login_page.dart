import 'dart:math';

import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:blackmoon_tattoos/auth.dart';
import 'package:blackmoon_tattoos/forget_password.dart';
import 'package:blackmoon_tattoos/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailX = TextEditingController();
  TextEditingController passX = TextEditingController();

  @override
  void dispose() {
    emailX.dispose();
    passX.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff000000),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Logo.png',
                      scale: 3.6,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      'Please sign up or login to contribute to use this app.',
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Log In',
                    style: GoogleFonts.oswald(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Email Address',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ContainerOne(
                    hinttxt: 'exp@gmail.com',
                    vld: (_) {
                      var email =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (_ == null || _ == '') {
                        return ' Enter Your Mail';
                      } else if (email.hasMatch(_)) {
                        return null;
                      } else
                        return "Wrong Email Adress";
                    },
                    PageController: emailX,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ContainerOne(
                    obs: true,
                    hinttxt: '*********',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Must Enter Password';
                      } else if (_.length < 6) {
                        return 'should at least 6 character';
                      }
                    },
                    PageController: passX,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.oswald(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        )
                      : Button(
                          text: 'Log In',
                          fnc: () {
                            if (_formKey.currentState!.validate()) {
                              Login();
                            }
                          }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account? ',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.oswald(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffE44245),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  late FirebaseAuth auth;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Future Login() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: emailX.text, password: passX.text);

      setState(() {
        isLoading = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Auth(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(
                  e.message.toString(),
                  style: GoogleFonts.oswald(fontSize: 16, color: Colors.red),
                ),
                actions: const [CloseButton()],
              ));
      return false;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
