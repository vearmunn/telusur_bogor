// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/main_menu/home/tempat/presentation/pages/place_detail.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/saved_places_cubit/saved_places_cubit.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

import '../main_menu/home/tempat/domain/models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final EdgeInsetsGeometry padding;
  final bool inVerticalList;
  final bool showAddToTripboardButton;
  const PlaceCard({
    super.key,
    required this.place,
    required this.padding,
    this.inVerticalList = true,
    this.showAddToTripboardButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => PlaceDetail(
                    place: place,
                    showAddToTripboardButton: showAddToTripboardButton,
                  ),
            ),
          ),
      child: Padding(
        padding: padding,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(place.images[0], fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: -50,
              child: Container(
                width:
                    inVerticalList
                        ? MediaQuery.of(context).size.width - 52
                        : MediaQuery.of(context).size.width - 62,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.15),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(place.description, style: TextStyle(fontSize: 12)),
                    verticalSpace(12),
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
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return GestureDetector(
                      onTap: () async {
                        final savedPlacesCubit =
                            context.read<SavedPlacesCubit>();
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
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          state.profile.savedIdPlaceList.contains(place.id)
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          color:
                              state.profile.savedIdPlaceList.contains(place.id)
                                  ? mainColor
                                  : Colors.white,
                        ),
                      ),
                    );
                  }
                  return CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
