import 'package:blackmoon_tattoos/Model_data/artist_data.dart';
import 'package:blackmoon_tattoos/Model_data/artist_favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenContainer extends StatefulWidget {
  ArtistData data;
  final Function fnc;

  HomeScreenContainer({Key? key, required this.data, required this.fnc}) : super(key: key);

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  bool fav_check = false;
  bool isLoading = false;
  List<ArtestFavorite> artestFavorite = [];
  List<ArtestFavorite> userFav = [];

  Future favorite() async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('ArtistFavorite')
        .where('artestId', isEqualTo: widget.data.id)
        .get();
    if (result.docs.isNotEmpty) {
      setState(() {
        artestFavorite =
            result.docs.map((e) => ArtestFavorite.fromMap(e.data() as Map<String, dynamic>)).toList();
        userFav = artestFavorite
            .where((element) => element.userId == FirebaseAuth.instance.currentUser?.uid)
            .toList();
        userFav.isNotEmpty ? fav_check = true : fav_check = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      favorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : InkWell(
            onTap: () {
              widget.fnc();
            },
            child: Stack(
              children: [
                Container(
                  height: screenHight / 3,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      image: DecorationImage(
                          image: NetworkImage("${widget.data.thumbnail}"), fit: BoxFit.fill)),
                ),
                Positioned(
                  top: 10,
                  left: 115,
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
                                  .collection('ArtistFavorite')
                                  .doc(userFav[0].id);
                              await userdoc.delete();
                              setState(() {
                                fav_check = false;
                                artestFavorite.remove(userFav[0]);
                                userFav.clear();
                              });
                            } else {
                              final favData =
                                  FirebaseFirestore.instance.collection('ArtistFavorite').doc();
                              ArtestFavorite artfav = ArtestFavorite(
                                  id: favData.id,
                                  artestId: widget.data.id,
                                  userId: FirebaseAuth.instance.currentUser!.uid);
                              await favData.set(artfav.tMap());
                            }
                            favorite();
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
                  top: 150,
                  left: 10,
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
                  left: 95,
                  top: 210,
                  child: Container(
                    height: 30,
                    width: 55,
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          artestFavorite.isNotEmpty ? artestFavorite.length.toString() : '0',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          artestFavorite.isNotEmpty ? Icons.favorite : Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
