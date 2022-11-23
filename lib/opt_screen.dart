import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:blackmoon_tattoos/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
              'Ener OTP',
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
                        'Please enter your one time password that is sent on \nyour email (exp@gmail.com)',
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
                  vld: (_) {},
                ),
                const SizedBox(
                  height: 40,
                ),
                Button(
                    text: 'Submit',
                    fnc: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend OTP',
                      style: GoogleFonts.oswald(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffE44245),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
