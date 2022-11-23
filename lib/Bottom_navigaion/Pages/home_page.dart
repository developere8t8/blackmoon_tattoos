import 'package:blackmoon_tattoos/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Widgets/home_screen_container.dart';
import 'package:blackmoon_tattoos/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<ArtistData> artestdata = [];
  @override
  void initState() {
    super.initState();
    getArtestData();
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
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xff000000),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.4,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/tato1.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Image.asset(
                      'assets/images/Logo.png',
                      scale: 5.8,
                    ),
                    Positioned(
                      top: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Every Day is',
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
                          'Consultation Day',
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Available Artists',
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: artestdata.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10, top: 5),
                        child: HomeScreenContainer(
                          data: artestdata[index],
                          fnc: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation(
                                          page: 1,
                                          data: artestdata[index],
                                        )));
                          },
                        ),
                      );
                    }),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Follow Us On:',
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchUrl('www.facebook.com/blackmoontattoocompany');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color(0xffE44245),
                        child: Center(
                          child: Image.asset(
                            'assets/images/fbb.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('www.instagram.com/black_moon_tattoo/');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color(0xffE44245),
                        child: Center(
                          child: Image.asset(
                            'assets/images/insta.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('www.tiktok.com');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color(0xffE44245),
                        child: Center(
                          child: Image.asset(
                            'assets/images/tok.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('www.youtube.com/channel/UCCH4yzWIYK79DyWxLldEBBw');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color(0xffE44245),
                        child: Center(
                          child: Image.asset(
                            'assets/images/tube.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getArtestData() async {
    QuerySnapshot res =
        await FirebaseFirestore.instance.collection('ArtistData').where('active', isEqualTo: true).get();

    if (res.docs.isNotEmpty) {
      setState(() {
        artestdata = res.docs
            .map(
              (e) => ArtistData.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
      });
    }
  }

  Future<void> _launchUrl(String address) async {
    final Uri toLaunch = Uri(scheme: 'https', path: Uri.parse(address).toString());

    await launchUrl(toLaunch, mode: LaunchMode.inAppWebView);
  }
}
