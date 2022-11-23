import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double ZOOM = 14.5;

class HomeView extends StatelessWidget {
  static GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          height: 300,
          width: 300,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Location").snapshots(),
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                //Extract the location from document
                GeoPoint location = snapshot.data!.docs.first.get("location");

                // Check if location is valid
                if (location == null) {
                  return Text("There was no location data");
                }

                // Remove any existing markers
                markers.clear();

                final latLng = LatLng(location.latitude, location.longitude);

                // Add new marker with markerId.
                markers.add(Marker(
                    markerId: MarkerId("Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRose),
                    position: latLng));

                // If google map is already created then update camera position with animation
                _googleMapController
                    ?.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: latLng,
                    zoom: ZOOM,
                  ),
                ));

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(location.latitude, location.longitude)),
                  // Markers to be pointed
                  markers: markers,
                  onMapCreated: (controller) {
                    // Assign the controller value to use it later
                    _googleMapController = controller;
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GoogleMapController>(
        '_googleMapController', _googleMapController));
  }
}
