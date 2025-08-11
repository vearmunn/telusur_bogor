// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

import '../../domain/models/place.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;
  const PlaceDetail({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            color: Colors.amber,
            child: Image.network(place.images[0], fit: BoxFit.cover),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleIcon(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.arrow_back,
                ),
                _buildCircleIcon(onTap: () {}, icon: Icons.bookmark_outline),
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45 - 30,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 16,
                            color: Colors.grey,
                          ),
                          horizontalSpace(6),
                          Expanded(
                            child: Text(
                              place.address,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(16),
                      Text(place.description, style: TextStyle()),
                      verticalSpace(20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(
                                place.latitude,
                                place.longitude,
                              ),
                              initialZoom: 14,
                              minZoom: 0,
                              maxZoom: 100,
                            ),
                            children: [
                              TileLayer(
                                // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                urlTemplate:
                                    "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=ChX0SylTxwIcoIr5Vid2",
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 120,
                                    height: 60,
                                    point: LatLng(
                                      place.latitude,
                                      place.longitude,
                                    ),
                                    child: Column(
                                      children: [
                                        Text('Lokasi'),
                                        Icon(
                                          Icons.location_on,
                                          color: mainColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector _buildCircleIcon({
    required VoidCallback onTap,
    required IconData icon,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
