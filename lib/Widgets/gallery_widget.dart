import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/see_al_screen_gallery.dart';
import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Model_data/tatto_model_data.dart';
import 'package:blackmoon_tattoos/Widgets/gallery_screen_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Bottom_navigaion/Pages/appointment_pages/appointment_one.dart';

class GalleryWidget extends StatefulWidget {
  GalleryWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ArtistData data;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  bool isLoading = false;
  List<TattoModelData> currentAtrtistTatoos = [];

  @override
  void initState() {
    getArtistTatoos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? Center(
            child: SizedBox(
              child: Container(),
            ),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "${widget.data.name}",
                      style: GoogleFonts.oswald(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: InkWell(
                      onTap: () {
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeAllScreenGallery(
                                tattoData: currentAtrtistTatoos,
                                data: widget.data,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: screenHight / 18,
                        width: screenWidth / 3.4,
                        color: const Color(0xffE44245),
                        child: Center(
                          child: Text(
                            'See All',
                            style: GoogleFonts.oswald(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Row(
                  children: [
                    Text('scroll to view more'),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenWidth,
                height: screenHight / 3,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentAtrtistTatoos.isEmpty ? 0 : currentAtrtistTatoos.length,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(3.0),
                      child: Gallery_Screen_Container(
                        tattoData: currentAtrtistTatoos[index],
                        data: widget.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentOne(data: widget.data),
                    ),
                  );
                },
                child: Container(
                  height: screenHight / 14,
                  width: screenWidth / 1.2,
                  color: const Color(0xffE44245),
                  child: Center(
                    child: Text(
                      'Schedule A meeting',
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }

  Future getArtistTatoos() async {
    setState(() {
      isLoading = true;
    });

    for (var i in widget.data.tatto!) {
      QuerySnapshot snap =
          await FirebaseFirestore.instance.collection('TattoosData').where('id', isEqualTo: i).get();
      if (snap.docs.isNotEmpty) {
        TattoModelData tatooData =
            TattoModelData.fromMap(snap.docs.first.data() as Map<String, dynamic>);
        currentAtrtistTatoos.add(tatooData);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
