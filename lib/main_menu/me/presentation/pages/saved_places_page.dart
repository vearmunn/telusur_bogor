// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/main_menu/me/presentation/cubit/saved_places_cubit/saved_places_cubit.dart';
import 'package:telusur_bogor/widgets/place_card.dart';

class SavedPlacesPage extends StatelessWidget {
  final String uid;
  const SavedPlacesPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Places')),
      body: BlocBuilder<SavedPlacesCubit, SavedPlacesState>(
        builder: (context, state) {
          if (state is SavedPlacesError) {
            return Center(child: Text(state.errMessage));
          }
          if (state is SavedPlacesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SavedPlacesLoaded) {
            if (state.places.isEmpty) {
              return Center(child: Text('Kosong'));
            }
            return ListView.builder(
              itemCount: state.places.length,
              itemBuilder: (BuildContext context, int index) {
                final place = state.places[index];
                return PlaceCard(
                  place: place,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
