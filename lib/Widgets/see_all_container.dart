import 'package:blackmoon_tattoos/Bottom_navigaion/Pages/zoo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeeAllContainer extends StatefulWidget {
  // List<TattoModelData> image;
  final String image;
  final String title;

  SeeAllContainer({Key? key, required this.image, required this.title}) : super(key: key);

  @override
  State<SeeAllContainer> createState() => _SeeAllContainerState();
}

class _SeeAllContainerState extends State<SeeAllContainer> {
  var chk;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Zoom(title: widget.title, imgUrl: widget.image)));
            },
            child: Stack(
              children: [
                Container(
                  height: screenHight / 3,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    image: DecorationImage(image: NetworkImage("${widget.image}"), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          );
  }
}
