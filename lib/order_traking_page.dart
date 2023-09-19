import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  // var latitude;
  // var longitude;

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     Position position = await _determinePosition();

      //     googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //             target: LatLng(position.latitude, position.longitude),
      //             zoom: 14)));

      //     markers.clear();

      //     markers.add(Marker(
      //         markerId: const MarkerId('currentLocation'),
      //         position: LatLng(position.latitude, position.longitude)));

      //     setState(() {});
      //   },
      //   label: const Text("Current Location"),
      //   icon: const Icon(Icons.location_history),
      // ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}












// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';

// class OrderTrackingPage extends StatefulWidget {
//   const OrderTrackingPage({Key? key}) : super(key: key);

//   @override
//   State<OrderTrackingPage> createState() => OrderTrackingPageState();
// }

// class OrderTrackingPageState extends State<OrderTrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();

//   //static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   //static const LatLng destination = LatLng(37.33429383, -122.06600055);

//   LocationData? currentLocation;
//   String lat = "";
//   String lon = "";

//   void getCurrentLocation() {
//     Location location = Location();
//     location.getLocation().then(
//       (location) {
//         currentLocation = location;
//       },
//     );
//   }

//   @override
//   void initState() {
//     getCurrentLocation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "",
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ),
//       body: currentLocation == null
//           ? const Center(child: Text("Ashchei Je Na"))
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                     currentLocation!.latitude!, currentLocation!.longitude!),
//               ),
//               markers: {
//                 Marker(
//                     markerId: const MarkerId("Current"),
//                     position: LatLng(currentLocation!.latitude!,
//                         currentLocation!.longitude!)),
//               },
//             ),
//     );
//   }
// }
