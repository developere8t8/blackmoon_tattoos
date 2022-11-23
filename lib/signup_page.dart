import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:blackmoon_tattoos/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController emailX = TextEditingController();
  TextEditingController passX = TextEditingController();
  TextEditingController confirmpassx = TextEditingController();

  @override
  void dispose() {
    emailX.dispose();
    passX.dispose();
    confirmpassx.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff000000),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 15),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.oswald(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 15),
                        child: Text(
                          'Please sign up to continue Further.',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                        return 'Enter Your Mail';
                      } else if (email.hasMatch(_)) {
                        return null;
                      } else {
                        return "Wrong Email Adress";
                      }
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
                        return 'Enter Your Password';
                      } else if (_.length < 7) {
                        return 'Password should at least 7 characters';
                      }
                      return null;
                    },
                    PageController: passX,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Confirm Password',
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
                        return 'Enter Confirm Password';
                      } else if (_.length < 7) {
                        return 'Password should at least 7 characters';
                      }
                      return null;
                    },
                    PageController: confirmpassx,
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
                          text: 'Sign Up',
                          fnc: () {
                            if (_formKey.currentState!.validate()) {
                              if (passX.text != confirmpassx.text) {
                                showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        content: Text(
                                          'Password are not same',
                                          style: GoogleFonts.oswald(fontSize: 16, color: Colors.red),
                                        ),
                                        actions: const [CloseButton()],
                                      )),
                                );
                              } else {
                                signup();
                              }
                            }
                          }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffE44245),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                                children: const [
                              TextSpan(text: 'By submitting this form, you agree and accept'),
                              TextSpan(
                                text: 'Terms and conditions',
                                style: TextStyle(
                                  color: Color(0xfffe44245),
                                ),
                              ),
                              TextSpan(text: 'And'),
                              TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                  color: Color(0xfffe44245),
                                ),
                              ),
                              TextSpan(text: ' of black moon tattoo company.'),
                            ])),
                      ],
                    ),
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

  Future signup() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential credential =
          await auth.createUserWithEmailAndPassword(email: emailX.text, password: passX.text);
      User? user = credential.user;
      if (user != null) {
        await CreatDataBase(user.uid);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: const Text(
            "User Sign Up SuccessFully",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: const Duration(seconds: 2),
        ));
      }
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Auth()));
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: Text(
                e.message.toString(),
                style: GoogleFonts.oswald(fontSize: 16, color: Colors.red),
              ),
              actions: const [CloseButton()],
            )),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: Text(
                e.toString(),
                style: GoogleFonts.oswald(fontSize: 16, color: Colors.red),
              ),
              actions: const [CloseButton()],
            )),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future CreatDataBase(String uid) async {
    Map<String, dynamic> data = {
      "Email": emailX.text,
      "Phone": 0.toInt(),
      "First Name": '',
      'Last Name': '',
      "UserId": uid,
    };
    await FirebaseFirestore.instance.collection('Users').doc(uid).set(data);
  }
}
