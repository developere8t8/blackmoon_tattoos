import 'package:blackmoon_tattoos/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webview_flutter/webview_flutter.dart';

class AppointmentTwo extends StatefulWidget {
  final String calendlyLink;
  const AppointmentTwo({Key? key, required this.calendlyLink}) : super(key: key);

  @override
  State<AppointmentTwo> createState() => _AppointmentTwoState();
}

class _AppointmentTwoState extends State<AppointmentTwo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => BottomNavigation()));
              },
              icon: Image.asset(
                'assets/images/back.png',
                color: Color(0xffE44245),
                scale: 3,
              ),
            ),
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: WebView(
              initialUrl: widget.calendlyLink,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),
    );
  }
}
