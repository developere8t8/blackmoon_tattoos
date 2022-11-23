import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {

  final String text;
  final Function fnc;

  const Button({Key? key, required this.text, required this.fnc}) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      height: screenHight / 15,
      minWidth: screenWidth / 1.2,
      color: Color(0xffE44245),
      onPressed: () {
        widget.fnc();
      },
      child: Text(
        widget.text,
        style:GoogleFonts.oswald(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
