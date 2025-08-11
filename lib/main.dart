import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/firebase_options.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/data/repository/api_weather_repo.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/presentation/cubit/weather_cubit.dart';
import 'package:telusur_bogor/main_menu/home/tempat/data/repository/firestore_place_repo.dart';
import 'package:telusur_bogor/main_menu/home/homepage/presentation/cubit/tempat_cubit.dart';
import 'package:telusur_bogor/main_menu/home/tempat/presentation/cubit/list_tempat_cubit.dart';
import 'package:telusur_bogor/main_menu/main_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final apiWeatherRepo = ApiWeatherRepo();
  final firestorePlaceRepo = FirestorePlaceRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherCubit(apiWeatherRepo)),
        BlocProvider(create: (context) => TempatHomeCubit(firestorePlaceRepo)),
        BlocProvider(create: (context) => ListTempatCubit(firestorePlaceRepo)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: MainMenuPage(),
    );
  }
}
