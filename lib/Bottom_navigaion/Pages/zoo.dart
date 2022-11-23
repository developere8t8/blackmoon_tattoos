import 'package:flutter/material.dart';

class Zoom extends StatefulWidget {
  final String title;
  final String imgUrl;
  const Zoom({Key? key, required this.title, required this.imgUrl}) : super(key: key);

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [InteractiveViewer(child: Image.network(widget.imgUrl))],
      )),
    ));
  }
}
