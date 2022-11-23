import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Model_data/tatoo_favroite.dart';
import 'package:blackmoon_tattoos/Model_data/tatto_model_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gallery_Screen_Container extends StatefulWidget {
  ArtistData data;
  TattoModelData tattoData;

  Gallery_Screen_Container({Key? key, required this.data, required this.tattoData}) : super(key: key);

  @override
  State<Gallery_Screen_Container> createState() => _Gallery_Screen_ContainerState();
}

class _Gallery_Screen_ContainerState extends State<Gallery_Screen_Container> {
  bool fav_check = false;
  bool isLoading = false;
  List<TattoFavrite> tattoFavriteall = [];
  List<TattoFavrite> tattoFavUser = [];

  TattoFavrite? tattoFavritemodel;

  @override
  void initState() {
    super.initState();
    favorite();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHight / 3,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    image: DecorationImage(
                        image: NetworkImage(widget.tattoData.tattos![0]), fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 33,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () async {
                          if (fav_check) {
                            final userdoc = FirebaseFirestore.instance
                                .collection('TattoFavrite')
                                .doc(tattoFavUser[0].id);
                            await userdoc.delete();
                            setState(() {
                              fav_check = false;
                              tattoFavriteall.remove(tattoFavriteall[0]);
                              tattoFavUser.clear();
                            });
                            favorite();
                          } else {
                            final favData = FirebaseFirestore.instance.collection('TattoFavrite').doc();
                            TattoFavrite tattoofav = TattoFavrite(
                                tattooId: widget.tattoData.id,
                                id: favData.id,
                                userId: FirebaseAuth.instance.currentUser!.uid);
                            await favData.set(tattoofav.toMap());
                            favorite();
                          }
                        },
                        icon: Icon(
                          fav_check ? Icons.favorite : Icons.favorite_border_outlined,
                          size: 18,
                          color: fav_check ? Colors.red : Colors.white,
                        )),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.name}',
                      style: GoogleFonts.oswald(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${widget.data.type}',
                      style: GoogleFonts.oswald(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15,
                bottom: 15,
                child: Container(
                  height: 30,
                  width: 55,
                  color: Colors.white.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tattoFavriteall.isNotEmpty ? tattoFavriteall.length.toString() : '0',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        tattoFavriteall.isEmpty ? Icons.favorite_border_rounded : Icons.favorite,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }

  Future favorite() async {
    tattoFavriteall.clear();
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('TattoFavrite')
        .where('tattooId', isEqualTo: widget.tattoData.id)
        .get();
    if (result.docs.isNotEmpty) {
      setState(() {
        tattoFavriteall =
            result.docs.map((e) => TattoFavrite.fromMap(e.data() as Map<String, dynamic>)).toList();
        tattoFavUser = tattoFavriteall
            .where((element) => element.userId == FirebaseAuth.instance.currentUser!.uid)
            .toList();
        tattoFavUser.isNotEmpty ? fav_check = true : fav_check = false;
      });
    }
  }
}
