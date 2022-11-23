import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerOne extends StatefulWidget {
  final String hinttxt;
  final Function(String?) vld;
  final PageController;
  final obs;

  const ContainerOne(
      {Key? key,
      required this.hinttxt,
      required this.vld,
      this.PageController,
      this.obs})
      : super(key: key);

  @override
  State<ContainerOne> createState() => _ContainerOneState();
}

class _ContainerOneState extends State<ContainerOne> {
  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: screenHight / 15,
        width: screenWidth / 1.15,
        child: TextFormField(
          obscureText: widget.obs ?? false,
          style: GoogleFonts.oswald(
            color: Colors.white,
          ),
          validator: (_) => widget.vld(_),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 15,
              ),
              hintText: widget.hinttxt,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Color(0xffE44245), width: 2),
              )),
          cursorColor: Colors.white,
          controller: widget.PageController,
        ),
      ),
    );
  }
}
