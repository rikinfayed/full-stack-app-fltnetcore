import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../theme/toponymy_theme.dart';

class MapPickerScreen extends StatefulWidget {
  MapPickerScreen({Key? key}) : super(key: key);

  @override
  _MapPickerScreen createState() => _MapPickerScreen();
}

class _MapPickerScreen extends State<MapPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: _buildAppBar(context),
          preferredSize: AppBar().preferredSize,
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMapPicker(context),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildBottomSheet(context),
            )
          ],
        ));

    // return Center(child: GestureDetector(
    //   onTap: () {
    //     Future.delayed(Duration.zero, () {
    //     Navigator.pop(context, 20.0);
    //   });
    //   },
    //   child:Text("Picker"),),);
  }

  Marker? marker;

  LatLng initialPosition = LatLng(-6.211679831657398, 106.84641695511087);

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Widget _buildMapPicker(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        mapToolbarEnabled: false,
        markers: Set.of((marker != null) ? [marker!] : []),
        initialCameraPosition:
            CameraPosition(target: initialPosition, zoom: 14),
        onTap: (position) {
          setState(() {
            marker = Marker(
              markerId: MarkerId('marker1'),
              position: position,
              icon: BitmapDescriptor.defaultMarker,
            );

            initialPosition = position;
          });
        });
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Stack(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint("pressed");
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                )),
          ),
          Center(
              child: Text(
            "Get Position",
            style: Theme.of(context).textTheme.bodyText1,
          ))
        ]),
      ),
    );
  }

  _buildBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          _buildLatitudeInfo(context, "Latitude"),
          _buildLongitudeInfo(context, "Longitude"),
          Container(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                backgroundColor: const Color.fromRGBO(107, 78, 255, 1),
                padding: const EdgeInsets.only(
                    right: 32, left: 32, bottom: 12, top: 12),
              ).copyWith(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(255, 255, 255, 0.1),
                ),
              ),
              onPressed: () {
                if(marker != null) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context, marker);
                  });
                }
              },
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "inter",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatitudeInfo(BuildContext context, String label,
      {String? value}) {
    return Container(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 18, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label",
              style: ToponymyTheme.regular('none')
                  .copyWith(color: ToponymyTheme.inkDarkest)),
          Text(
            (marker != null) ? marker!.position.latitude.toString() : "",
            style: ToponymyTheme.regular('none').copyWith(
                color: (value != null)
                    ? ToponymyTheme.inkDarkest
                    : ToponymyTheme.skyDark),
          ),
        ],
      ),
    );
  }

  Widget _buildLongitudeInfo(BuildContext context, String label,
      {String? value}) {
    return Container(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 18, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label",
              style: ToponymyTheme.regular('none')
                  .copyWith(color: ToponymyTheme.inkDarkest)),
          Text(
            (marker != null) ? marker!.position.longitude.toString() : "",
            style: ToponymyTheme.regular('none').copyWith(
                color: (value != null)
                    ? ToponymyTheme.inkDarkest
                    : ToponymyTheme.skyDark),
          ),
        ],
      ),
    );
  }
}
