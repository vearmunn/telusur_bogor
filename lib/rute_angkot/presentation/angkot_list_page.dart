import 'package:flutter/material.dart';
import 'package:telusur_bogor/rute_angkot/domain/models/angkot_route.dart';
import 'package:telusur_bogor/rute_angkot/presentation/angkot_route_map_page.dart';

class AngkotListPage extends StatelessWidget {
  const AngkotListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rute Angkot')),
      body: ListView.builder(
        itemCount: angkotRoutes.length,
        itemBuilder: (BuildContext context, int index) {
          final route = angkotRoutes[index];
          return ListTile(
            title: Text(route.route),
            subtitle: Text(route.code),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AngkotRouteMapPage(
                          originLat: route.originLat,
                          originLon: route.originLon,
                          destinationLat: route.destinationLat,
                          destinationLon: route.destinationLon,
                          route: '${route.route} ${route.code}',
                        ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
