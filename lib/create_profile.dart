import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:blackmoon_tattoos/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Create_Profile extends StatefulWidget {
  const Create_Profile({Key? key}) : super(key: key);

  @override
  State<Create_Profile> createState() => _Create_ProfileState();
}

class _Create_ProfileState extends State<Create_Profile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lstName = TextEditingController();
  TextEditingController phonNumber = TextEditingController();

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
                          'Create Profile',
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
                          'Please Set your personal information.',
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
                          'First Name',
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
                    hinttxt: 'e.g Shuny',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Must Enter Name';
                      } else if (_.length < 3) {
                        return 'Name should at least 3 characters';
                      }
                      return null;
                    },
                    PageController: firstName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Last Name',
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
                    hinttxt: 'e.g Bae',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Must Enter Name';
                      } else if (_.length < 3) {
                        return 'Name should at least 3 characters';
                      }
                      return null;
                    },
                    PageController: lstName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Phone Number',
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
                    hinttxt: 'Enter Phone number',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Must Enter Number';
                      } else if (_.length < 12) {
                        return 'Phone Number should at least 12 Numbers';
                      }
                      return null;
                    },
                    PageController: phonNumber,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    text: 'Create Profile',
                    fnc: () {
                      if (_formKey.currentState!.validate()) {
                        UpdateDataBase(FirebaseAuth.instance.currentUser!.uid);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          content: const Text(
                            "User Profile Done",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          duration: const Duration(seconds: 2),
                        ));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        firstName.clear();
                        lstName.clear();
                        phonNumber.clear();
                      }
                    },
                  ),
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

  Future UpdateDataBase(String uid) async {
    Map<String, dynamic> data = {
      "Phone": phonNumber.text,
      "First Name": firstName.text,
      'Last Name': lstName.text,
      "UserId": FirebaseAuth.instance.currentUser!.uid,
    };
    await FirebaseFirestore.instance.collection('Users').doc(uid).update(data);
  }
}
