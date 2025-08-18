// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/tripboard_cubit/tripboard_cubit.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

import '../../../../me/presentation/cubit/saved_places_cubit/saved_places_cubit.dart';
import '../../domain/models/place.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;
  final bool showAddToTripboardButton;
  const PlaceDetail({
    super.key,
    required this.place,
    this.showAddToTripboardButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: [
          _buildPlaceImages(context),
          _buildTopButtons(context),
          _buildPlaceDetails(context),
        ],
      ),
      bottomSheet:
          showAddToTripboardButton
              ? Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TripboardCubit>().fetchAllTripboards;
                    _buildTripboardListSheet(context);
                  },
                  child: Text('Add to Tripboard'),
                ),
              )
              : null,
    );
  }

  Future<dynamic> _buildTripboardListSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Tripboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<TripboardCubit, TripboardState>(
                  builder: (context, state) {
                    if (state is TripboardLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is TripboardLoaded) {
                      return ListView.builder(
                        itemCount: state.tripboardList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final tripboard = state.tripboardList[index];
                          return ListTile(
                            title: Text(tripboard.name),
                            subtitle: Text(
                              '${tripboard.idPlaceList.length} tempat',
                            ),
                            onTap: () {
                              if (tripboard.idPlaceList.contains(place.id)) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Tempat sudah ditambahkan ke tripboard ini!',
                                    ),
                                  ),
                                );
                              } else {
                                context.read<TripboardCubit>().addToTripboard(
                                  tripboardId: tripboard.id,
                                  placeId: place.id,
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPlaceImages(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.amber,
      child: Image.network(place.images[0], fit: BoxFit.cover),
    );
  }

  Widget _buildPlaceDetails(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.45 - 30,
            ),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            width: double.infinity,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                verticalSpace(6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin, size: 16, color: Colors.grey),
                    horizontalSpace(6),
                    Expanded(
                      child: Text(
                        place.address,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
                        initialCenter: LatLng(place.latitude, place.longitude),
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
                              point: LatLng(place.latitude, place.longitude),
                              child: Column(
                                children: [
                                  Text('Lokasi'),
                                  Icon(Icons.location_on, color: mainColor),
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
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIcon(
            onTap: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return _buildCircleIcon(
                  onTap: () async {
                    final savedPlacesCubit = context.read<SavedPlacesCubit>();
                    final profileCubit = context.read<ProfileCubit>();
                    if (state.profile.savedIdPlaceList.contains(place.id)) {
                      await savedPlacesCubit.removeFromSavedPlaces(
                        state.profile.uid,
                        place.id,
                      );
                    } else {
                      await savedPlacesCubit.addToSavedPlaces(
                        state.profile.uid,
                        place.id,
                      );
                    }
                    profileCubit.loadProfile();
                  },
                  color:
                      state.profile.savedIdPlaceList.contains(place.id)
                          ? mainColor
                          : Colors.white,
                  icon:
                      state.profile.savedIdPlaceList.contains(place.id)
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon({
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
