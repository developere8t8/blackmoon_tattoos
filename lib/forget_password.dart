import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff000000),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color(0xff000000),
            title: Text(
              'Forgot Password',
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25),
                        child: Text(
                          'Please enter your email address and we will send \nan Email on your Spam Folder to resent your password.',
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
                        return ' Enter Your Mail';
                      } else if (email.hasMatch(_)) {
                        return null;
                      } else {
                        return "Wrong Email Adress";
                      }
                    },
                    PageController: email,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                      text: 'Reset',
                      fnc: () {
                        if (_formKey.currentState!.validate()) {
                          resetPassword().then((value) {
                            Navigator.pop(context);
                          });
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
    try {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        content: const Text(
          "Check your Email Spam Folder",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        duration: const Duration(seconds: 2),
      ));
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        content: Text(
          "${e.message}",
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
