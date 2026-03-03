import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapModalContent extends StatefulWidget {
  const MapModalContent({
    required this.latitude,
    required this.longitude,

    super.key,
  });
  final double latitude;
  final double longitude;

  @override
  State<MapModalContent> createState() => _MapModalContentState();
}

class _MapModalContentState extends State<MapModalContent> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(widget.latitude, widget.longitude),
        initialZoom: 15.0,
      ),
      children: [
        TileLayer(
          // Bring your own tiles
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
          userAgentPackageName: 'com.example.flutter_application_1_app_car',
          // Add your app identifier
          // And many more recommended properties!
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(widget.latitude, widget.longitude),
              width: 80,
              height: 80,
              child: const Icon(Icons.location_on, color: Colors.red, size: 45),
            ),
          ],
        ),
        RichAttributionWidget(
          // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(
                Uri.parse('https://openstreetmap.org/copyright'),
              ), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }
}
