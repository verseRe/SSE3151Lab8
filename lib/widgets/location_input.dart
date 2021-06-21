import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationInput extends StatefulWidget {
  bool active = false;
  final Function location;
  LocationInput(this.location);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String place = "No Location"; // Default Value

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(Duration(seconds: 5));
    try {
      if (widget.active) {
        setState(() {
          widget.active = false;
          place = "No Location";
        });
      }
      else {
        setState(() {
          widget.active = true;
        });
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark _pM = placemarks[0];
        place = _pM.subLocality + ", " + _pM.postalCode + " " + _pM.locality + ", " + _pM.administrativeArea + ", " + _pM.country;
      }

      widget.location(place);
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Location : ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextButton.icon(
            onPressed: _getCurrentLocation,
            icon: widget.active ? Icon(Icons.location_on_sharp, size: 40,) : Icon(Icons.location_off, size: 40,),
            label: Text(""),
          ),
        ),
      ],
    );
  }
}
