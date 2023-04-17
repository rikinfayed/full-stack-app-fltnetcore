import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toponymy/src/place/place.dart';
import 'package:toponymy/src/theme/toponymy_theme.dart';

import 'package:toponymy/src/home/component/component.dart';

import '../../maps/maps.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
        //TODO key and name
        name: "addplace",
        child: AddPlaceScreen());
  }

  @override
  _AddPlaceScreen createState() => _AddPlaceScreen();
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            SizedBox(
              height: 4,
            ),
            Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                    )),
              ),
              Center(
                child: Text(
                  "Add new place to Mark",
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24)),
                                  height: 150,
                                  child: buildMapPicker()),
                              const SizedBox(
                                height: 16,
                              ),
                              buildSearchMap(context, "Search on map",
                                  Icons.fmd_good_outlined),
                              const SizedBox(
                                height: 16,
                              ),
                              buildTextFieldPlaceName(context),
                              const SizedBox(
                                height: 16,
                              ),
                              buildTextFieldOwnerName(context),
                              const SizedBox(
                                height: 16,
                              ),
                              buildTextFieldAddress(context),
                              const SizedBox(
                                height: 16,
                              ),
                              buildDropDownBottomLocation(),
                              const SizedBox(
                                height: 16,
                              ),
                              const Divider(
                                height: 1.0,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _buildBottomSheet(context),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            )
          ])),
    ));
  }

  Widget buildSearchMap(
      BuildContext context, String label, IconData icon_data) {
    return GestureDetector(
      onTap: () async {
        Marker? marker = await Navigator.push<Marker>(
            context, MaterialPageRoute(builder: (_) => MapPickerScreen()));

        if (marker != null) {
          setState(() {
            markers[marker.markerId.toString()] = marker;
            _marker = marker;
            initialPosition = marker.position;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Icon(
                icon_data,
                size: 32.0,
              ),
              padding: const EdgeInsets.only(right: 12),
            ),
            SizedBox(
              width: 12,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "$label",
                style: ToponymyTheme.regular('none')
                    .copyWith(color: ToponymyTheme.inkDarkest),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController textPlaceName = TextEditingController();

  buildTextFieldPlaceName(BuildContext context) {
    return TextField(
      controller: textPlaceName,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        hintText: 'place name',
      ),
    );
  }

  TextEditingController textOwenerName = TextEditingController();

  buildTextFieldOwnerName(BuildContext context) {
    return TextField(
      controller: textOwenerName,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        hintText: 'owner name',
      ),
    );
  }

  TextEditingController textAddress = TextEditingController();

  buildTextFieldAddress(BuildContext context) {
    return TextField(
      controller: textAddress,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        hintText: 'address',
      ),
    );
  }

  //mock storage logic
  String location = "Place"; //default value
  List<String> locations = ["Hospital", "School", "Office"];

  Widget buildDropDownBottomLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ToponymyBottomDropDown<String>(
        title: "Place Type",
        value: location,
        items: locations
            .map<CustomeCheckBox<String>>(
                (String value) => CustomeCheckBox<String>(
                      isChecked: value == location,
                      value: value,
                      onChange: (String? value) {
                        setState(() {
                          location = value!;
                        });
                      },
                      child: Text(
                        value,
                        style: ToponymyTheme.regular('none')
                            .copyWith(color: ToponymyTheme.inkDarkest),
                      ),
                    ))
            .toList(),
      ),
    );
  }

  _buildBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
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
                _onSubmit();
              },
              child: const Text(
                "Save",
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

  Map<String, Marker> markers = {};
  Marker? _marker;

  LatLng initialPosition = LatLng(-6.211679831657398, 106.84641695511087);

  Widget buildMapPicker() {
    return AbsorbPointer(
      absorbing: false,
      child: GoogleMap(
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        onMapCreated: _onMapCreated,
        mapToolbarEnabled: false,
        markers: markers.values.toSet(),
        initialCameraPosition:
            CameraPosition(target: initialPosition, zoom: 14),
      ),
    );
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onSubmit() {
    if (textOwenerName.text != "" &&
        textPlaceName.text != "" &&
        textAddress.text != "" &&
        location != "Place" &&
        _marker != null) {
      Place place = Place(
          nameOwner: textOwenerName.text,
          place: textPlaceName.text,
          address: textAddress.text,
          type: location,
          date: DateTime.now(),
          latitude: _marker!.position.latitude,
          longitude: _marker!.position.longitude);

      Provider.of<PlacesBloc>(context, listen: false).add(StorePlace(place));
      Navigator.pop(context);
    }
  }
}
