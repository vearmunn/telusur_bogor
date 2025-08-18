// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/widgets/place_card.dart';

import '../cubit/tripboard_cubit/tripboard_cubit.dart';

class TripboardDetailPage extends StatefulWidget {
  final String tripboardId;
  const TripboardDetailPage({super.key, required this.tripboardId});

  @override
  State<TripboardDetailPage> createState() => _TripboardDetailPageState();
}

class _TripboardDetailPageState extends State<TripboardDetailPage> {
  final nameController = TextEditingController();
  @override
  void initState() {
    context.read<TripboardCubit>().fetchTripboardPlaces(widget.tripboardId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<TripboardCubit>().fetchAllTripboards();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _buildEditTripboardNameDialog(context);
        //     },
        //     icon: Icon(Icons.edit_outlined),
        //   ),
        // ],
      ),
      body: BlocBuilder<TripboardCubit, TripboardState>(
        builder: (context, state) {
          if (state is TripboardLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TripboardError) {
            return Text(state.errMessage);
          }
          if (state is TripboardPlacesLoaded) {
            return ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      state.tripboard.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                state.tripboard.places.isEmpty
                    ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: Text('Kosong'),
                      ),
                    )
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.tripboard.places.length,
                      itemBuilder: (BuildContext context, int index) {
                        final place = state.tripboard.places[index];
                        return Dismissible(
                          key: ValueKey(place.id),
                          onDismissed: (direction) {
                            context.read<TripboardCubit>().removeFromTripboard(
                              tripboardId: state.tripboard.id,
                              placeId: place.id,
                            );
                          },
                          confirmDismiss: (direction) {
                            return showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text('Alert'),
                                    content: Text(
                                      'Hapus dari tripboard ${state.tripboard.name}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: PlaceCard(
                            place: place,
                            showAddToTripboardButton: false,
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
                          ),
                        );
                      },
                    ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<dynamic> _buildEditTripboardNameDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Edit Tripboard Name'),
            content: TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: 'Enter tripboard name...'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // context.read<TripboardCubit>().createNewTripboard(
                  //   nameController.text,
                  // );
                },
                child: Text('Submit'),
              ),
            ],
          ),
    );
  }
}
