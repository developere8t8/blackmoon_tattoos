import 'package:blackmoon_tattoos/Model_data/tatto_model_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop_Page extends StatefulWidget {
  const Shop_Page({Key? key}) : super(key: key);

  @override
  State<Shop_Page> createState() => _Shop_PageState();
}

class _Shop_PageState extends State<Shop_Page> {
  TattoModelData? tattoData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
          opacity: 0.5,
        )),
        child: Center(
          child: MaterialButton(
            onPressed: () {},
            child: Text(
              'Comming Soon',
              style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
