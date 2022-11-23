import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Model_data/tatto_model_data.dart';
import 'package:blackmoon_tattoos/Widgets/see_all_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllScreenGallery extends StatefulWidget {
  SeeAllScreenGallery({Key? key, required this.data, required this.tattoData}) : super(key: key);
  final ArtistData data;
  List<TattoModelData> tattoData;

  @override
  State<SeeAllScreenGallery> createState() => _SeeAllScreenGalleryState();
}

class _SeeAllScreenGalleryState extends State<SeeAllScreenGallery> {
  List<String> tatooImages = [];
  @override
  void initState() {
    getallTatoosImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff000000),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Tattoos by ${widget.data.name}',
              style: GoogleFonts.oswald(fontSize: 24, color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.9,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/tato4.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 91,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text(
                          'Tatto By',
                          style: GoogleFonts.oswald(
                            fontSize: 50,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text(
                          '${widget.data.name}',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 33,
                            fontWeight: FontWeight.w500,
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
                GridView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: tatooImages.isEmpty ? 0 : tatooImages.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10, top: 5),
                        child: SeeAllContainer(
                          image: '${tatooImages[index]}',
                          title: 'Tattoos by ${widget.data.name}',
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getallTatoosImages() async {
    for (var i in widget.tattoData) {
      for (var j in i.tattos!) {
        setState(() {
          tatooImages.add(j);
        });
      }
    }
  }
}
