import 'package:flutter/material.dart';

class HomeScreenMap extends StatefulWidget {
  const HomeScreenMap({super.key});

  @override
  State<HomeScreenMap> createState() {
    return _HomeScreenMapState();
  }
}

class _HomeScreenMapState extends State<HomeScreenMap> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        panEnabled: true, // Set it to false if you don't want the image to be panned
        boundaryMargin: const EdgeInsets.all(0),
        minScale: 0.5,
        maxScale: 4.0,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/map_img.png'), // Update the path to your image
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
