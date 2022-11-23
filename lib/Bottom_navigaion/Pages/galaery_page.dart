import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Widgets/gallery_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class Gallery_Page extends StatefulWidget {
  ArtistData? data;
  Gallery_Page({
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<Gallery_Page> createState() => _Gallery_PageState();
}

class _Gallery_PageState extends State<Gallery_Page> {
  bool isLoading = false;
  List<ArtistData> artistData = [];

  @override
  void dispose() {
    widget.data = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getArtistData();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xff000000),
          body: isLoading
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
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
                                  'assets/images/tatogal.png',
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.8,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                'Gallery',
                                style: GoogleFonts.oswald(
                                  fontSize: 42,
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
                                'Tatto',
                                style: GoogleFonts.mrDafoe(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      widget.data == null
                          ? ListView.builder(
                              physics: const ScrollPhysics(),
                              itemCount: artistData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GalleryWidget(
                                  data: artistData[index],
                                );
                              },
                            )
                          : GalleryWidget(
                              data: widget.data!,
                            ),
                      const SizedBox(
                        height: 40,
                      ),
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
                              _launchUrl("www.facebook.com/blackmoontattoocompany");
                              //launch();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Color(0xffE44245),
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
                              color: Color(0xffE44245),
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
                              color: Color(0xffE44245),
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
                              color: Color(0xffE44245),
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

  Future getArtistData() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot res = await FirebaseFirestore.instance.collection('ArtistData').get();

    if (res.docs.isNotEmpty) {
      setState(() {
        artistData = res.docs
            .map(
              (e) => ArtistData.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _launchUrl(String address) async {
    final Uri toLaunch = Uri(scheme: 'https', path: Uri.parse(address).toString());

    await launchUrl(toLaunch, mode: LaunchMode.inAppWebView);
  }
}
