import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_collage/image_collage.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/tripboard_cubit/tripboard_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/pages/tripboard_detail_page.dart';

class TripboardPage extends StatefulWidget {
  const TripboardPage({super.key});

  @override
  State<TripboardPage> createState() => _TripboardPageState();
}

class _TripboardPageState extends State<TripboardPage> {
  @override
  void initState() {
    context.read<TripboardCubit>().fetchAllTripboards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tripboard')),
      body: _buildTripboardList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildAddTripboardDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTripboardList() {
    return BlocBuilder<TripboardCubit, TripboardState>(
      builder: (context, state) {
        if (state is TripboardError) {
          return Center(child: Text(state.errMessage));
        }
        if (state is TripboardLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TripboardLoaded) {
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.tripboardList.length,
            itemBuilder: (context, index) {
              final tripboard = state.tripboardList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TripboardDetailPage(tripboardId: tripboard.id),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.15),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child:
                            tripboard.imgUrlList!.isEmpty
                                ? Center(child: Text('Kosong'))
                                : ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: ImageCollage(
                                    onClick: (p0, p1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => TripboardDetailPage(
                                                tripboardId: tripboard.id,
                                              ),
                                        ),
                                      );
                                    },
                                    images:
                                        tripboard.imgUrlList!
                                            .map(
                                              (image) => Img(
                                                image: image,
                                                source: ImageSource.network,
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            tripboard.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Future _buildAddTripboardDialog(BuildContext context) {
    final nameController = TextEditingController();
    return showDialog(
      context: context,
      builder:
          (context) => BlocConsumer<TripboardCubit, TripboardState>(
            listener: (context, state) {
              if (state is TripboardSuccess) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            TripboardDetailPage(tripboardId: state.tripboardId),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TripboardLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is TripboardError) {
                return Center(child: Text(state.errMessage));
              }
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text('Add New Tripboard'),
                content: TextField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Enter tripboard name...',
                  ),
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
                      context.read<TripboardCubit>().createNewTripboard(
                        nameController.text,
                      );
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          ),
    );
  }
}
