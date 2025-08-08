import 'package:flutter/material.dart';
import 'package:telusur_bogor/pages/map_view.dart';
import 'package:telusur_bogor/rute_angkot/presentation/angkot_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AngkotListPage(),
    );
  }
}
