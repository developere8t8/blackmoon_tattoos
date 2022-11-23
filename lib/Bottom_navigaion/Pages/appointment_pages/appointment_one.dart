import 'dart:convert';
import 'dart:math';

import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/appointment_pages/appointment_two.dart';
import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentOne extends StatefulWidget {
  final ArtistData data;
  AppointmentOne({Key? key, required this.data}) : super(key: key);

  @override
  State<AppointmentOne> createState() => _AppointmentOneState();
}

class _AppointmentOneState extends State<AppointmentOne> {
  String? dropdownValue;

  List<String> artestName = [];

  List<ArtistData> artData = [];

  getArtistData() async {
    // QuerySnapshot snap =
    //     await FirebaseFirestore.instance.collection('ArtistData').where('active', isEqualTo: true).get();
    // if (snap.docs.isNotEmpty) {
    //   setState(() {
    //     artData = snap.docs.map((e) => ArtistData.fromMap(e.data() as Map<String, dynamic>)).toList();
    //     for (var i in artData) {
    //       artestName.add(i.name!);
    //     }
    //     dropdownValue = widget.name;
    //   });
    // }
    setState(() {
      dropdownValue = widget.data.name!;
      artestName.add(widget.data.name!);
    });
  }

  @override
  void initState() {
    super.initState();
    getArtistData();
    // dropdownValue = null;
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/images/back.png',
                color: Color(0xffE44245),
                scale: 3,
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xff000000),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/boi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Book An',
                          style: GoogleFonts.oswald(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Appointment',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Image.asset(
                //   'assets/images/11.PNG',
                // ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'Choose An Artist',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23.0, right: 23),
                  child: Container(
                      height: screenHight / 16,
                      width: screenWidth / 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffDDDCDC),
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 9),
                          child: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 25,
                            ),
                            value: dropdownValue,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Color(0xffC4C4C4), fontSize: 15),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: artestName.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 90,
                ),
                Button(
                    text: 'Continue',
                    fnc: () {
                      dropdownValue == null
                          ? showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    content: Text(
                                      'Select An Artist',
                                      style: GoogleFonts.oswald(fontSize: 16, color: Colors.red),
                                    ),
                                    actions: [CloseButton()],
                                  )),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentTwo(calendlyLink: widget.data.calendlyLink!),
                              ),
                            );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
