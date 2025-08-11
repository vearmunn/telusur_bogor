// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/main_menu/home/tempat/presentation/cubit/list_tempat_cubit.dart';
import 'package:telusur_bogor/widgets/place_card.dart';

class ListTempatPage extends StatefulWidget {
  const ListTempatPage({super.key, required this.tag});

  final String tag;

  @override
  State<ListTempatPage> createState() => _ListTempatPageState();
}

class _ListTempatPageState extends State<ListTempatPage> {
  @override
  void initState() {
    context.read<ListTempatCubit>().getPlaces(widget.tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tag} Places'),
        // actions: [
        //   IconButton(
        //     onPressed: () => context.read<TempatHomeCubit>().addPlace(),
        //     icon: Icon(Icons.add),
        //   ),
        // ],
      ),
      backgroundColor: Color(0xFFF8F8F8),
      body: BlocBuilder<ListTempatCubit, ListTempatState>(
        builder: (context, state) {
          if (state is ListTempatLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ListTempatError) {
            return Center(child: Text(state.errMessage));
          }
          if (state is ListTempatLoaded) {
            return ListView.builder(
              itemCount: state.placeList.length,
              itemBuilder: (BuildContext context, int index) {
                final place = state.placeList[index];
                return PlaceCard(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
                  place: place,
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
