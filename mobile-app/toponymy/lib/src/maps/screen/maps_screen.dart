import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../bloc/places_bloc.dart';
import '../models/models.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreen createState() => _MapsScreen();
}

class _MapsScreen extends State<MapsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesBloc, PlacesState>(
        listener: (context, placesState) {
          //TODO ERROR handling
        },
        builder: (context, placesState) {

          Widget widget = Center(child: CircularProgressIndicator());

          if (placesState is PlacesInitial) {
            Provider.of<PlacesBloc>(context, listen: false).add(LoadPlaces());
          }
          if (placesState is PlacesLoaded) {
            widget = GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              mapToolbarEnabled: false,
              markers: placesState.markers.values.toSet(),
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 11),
            );
          }

          return widget;
        });
  }

  //TODO Get posisision
  final LatLng _initialPosition =
      LatLng(-6.211679831657398, 106.84641695511087);

  final Map<String, Marker> _markers = {};

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    //mapController = controller;
    setState(() {
      // _markers.clear();
      // final marker = Marker(
      //     markerId: MarkerId("nama location"),
      //     position: _initialPosition,
      //     infoWindow: InfoWindow(title: "nama location", snippet: "deskripsi"));
      // _markers["nama location"] = marker;
    });
  }
}
