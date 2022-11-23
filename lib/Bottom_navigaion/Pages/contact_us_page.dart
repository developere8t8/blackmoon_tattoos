import 'package:blackmoon_tattoos/Model_data/location.dart';
import 'package:blackmoon_tattoos/Widgets/button.dart';
import 'package:blackmoon_tattoos/Widgets/container_one_txtfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Contact_Page extends StatefulWidget {
  const Contact_Page({Key? key}) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

// ignore: camel_case_types
class _Contact_PageState extends State<Contact_Page> {
  bool isLoading = false;
  TextEditingController emailX = TextEditingController();
  TextEditingController namex = TextEditingController();
  TextEditingController messegx = TextEditingController();

  static GoogleMapController? _googleMapController;
  GeoPoint? location;
  LatLng? latLng; //= LatLng(location.latitude, location.longitude);

  @override
  void dispose() {
    emailX.dispose();
    namex.dispose();
    messegx.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xff000000),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                                'assets/images/contactTato.png',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Request a',
                            style: GoogleFonts.oswald(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 175,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Consultation',
                            style: GoogleFonts.mrDafoe(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 260.0, left: 30, right: 30),
                        child: Container(
                          height: screenHight / 1.85,
                          width: screenWidth / 1.2,
                          color: const Color(0xff1D1F20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Get a Quote',
                                style: GoogleFonts.oswald(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffE44245),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: ContainerOne(
                                    PageController: namex,
                                    hinttxt: 'Your Name',
                                    vld: (_) {
                                      if (_ == null || _ == '') {
                                        return 'Must Enter Name';
                                      } else if (_.length < 3) {
                                        return 'Name should at least 3 characters';
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: ContainerOne(
                                    PageController: emailX,
                                    hinttxt: 'Your Email',
                                    vld: (_) {
                                      var email = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                      if (_ == null || _ == '') {
                                        return 'Enter Your Mail';
                                      } else if (email.hasMatch(_)) {
                                        return null;
                                      } else
                                        return "Wrong Email Adress";
                                    }),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: Container(
                                  height: screenHight / 7,
                                  width: screenWidth / 1.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: TextFormField(
                                    style: GoogleFonts.oswald(
                                      color: Colors.white,
                                    ),
                                    validator: (_) {
                                      if (_ == null || _ == '') {
                                        return 'Enter your Message';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
                                      hintText: 'Send Your Messege',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 5,
                                    cursorColor: Colors.white,
                                    obscureText: false,
                                    controller: messegx,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: Button(
                                  text: 'Submit',
                                  fnc: () {
                                    if (_formKey.currentState!.validate()) {
                                      CreatDataBase();
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Text(
                                                  'Alert',
                                                  style: GoogleFonts.oswald(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                content: Text(
                                                  'Messege Send',
                                                  style: GoogleFonts.oswald(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        namex.clear();
                                                        emailX.clear();
                                                        messegx.clear();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Ok',
                                                        style: GoogleFonts.oswald(
                                                          color: Colors.red,
                                                        ),
                                                      ))
                                                ],
                                              ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Direction',
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
                    height: 25,
                  ),
                  Container(
                    height: screenHight / 2.85,
                    width: screenWidth / 1.2,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(location!.latitude, location!.longitude),
                                  zoom: 17.4746),
                              // Markers to be pointed
                              markers: <Marker>{
                                Marker(
                                    markerId: const MarkerId('0'),
                                    position: LatLng(location!.latitude, location!.longitude),
                                    infoWindow: const InfoWindow(title: 'Black Moon Tattos'))
                              },
                              onMapCreated: (controller) {
                                // Assign the controller value to use it later
                                _googleMapController = controller;
                              },
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 80,
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
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    InkWell(
                      onTap: () {
                        _launchUrl("www.facebook.com/blackmoontattoocompany");
                        //launch();
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
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future CreatDataBase() async {
    Map<String, dynamic> data = {
      "Email": emailX.text,
      "Name": namex.text,
      'Message': messegx.text,
      "UserId": FirebaseAuth.instance.currentUser!.uid,
    };
    await FirebaseFirestore.instance.collection('GetQuote').doc().set(data);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<GoogleMapController>('_googleMapController', _googleMapController));
  }

  Future<void> _launchUrl(String address) async {
    final Uri toLaunch = Uri(scheme: 'https', path: Uri.parse(address).toString());

    await launchUrl(toLaunch, mode: LaunchMode.inAppWebView);
  }

  Future getLocation() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snap = await FirebaseFirestore.instance.collection("Location").get();
    setState(() {
      GeoLocationData data = GeoLocationData.fromMap(snap.docs.first.data() as Map<String, dynamic>);
      location = data.point;
      latLng = LatLng(location!.latitude, location!.longitude);
    });

    setState(() {
      isLoading = false;
    });
  }
}
