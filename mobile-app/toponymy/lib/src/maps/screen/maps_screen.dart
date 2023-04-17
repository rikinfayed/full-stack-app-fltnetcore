import 'package:flutter/foundation.dart';
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
          print(placesState);
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
                  CameraPosition(target: placesState.initialPosition, zoom: 11),
            );

            //mapController.animateCamera(CameraUpdate.newLatLngZoom(placesState.initialPosition, 14));
          }


          return widget;
        });
  }

  //TODO Get posisision
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    
    setState(() {
      mapController = controller;   
    });
  }
}
