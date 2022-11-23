import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/contact_us_page.dart';
import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/galaery_page.dart';
import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/home_page.dart';
import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/shop_page.dart';
import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavigation extends StatefulWidget {
  int? page;
  ArtistData? data;
  BottomNavigation({Key? key, this.data, this.page}) : super(key: key);

  @override
  _BottomNavigation createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Widget>? _widgetOptions; // =

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.page ?? 0;
    _widgetOptions = [
      Home_Page(),
      // NewPageTest(),
      Gallery_Page(data: widget.data),
      // HomeView(),
      const Shop_Page(),
      const Contact_Page(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff000000),
          body: _widgetOptions!.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.withOpacity(0.4),
            currentIndex: _selectedIndex,
            // this will be set when a new tab is tapped
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_library_outlined,
                ),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_sharp),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: 'Contact Us',
              ),
            ],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            selectedIconTheme: const IconThemeData(
              color: Color(0xffE44245),
            ),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            selectedItemColor: const Color(0xffE44245),
            // unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
