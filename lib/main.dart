import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/auth/data/repository/firestore_user_repo.dart';
import 'package:telusur_bogor/auth/presentation/cubit/auth_cubit.dart';
import 'package:telusur_bogor/auth/presentation/pages/login_or_register.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/firebase_options.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/data/repository/api_weather_repo.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/presentation/cubit/weather_cubit.dart';
import 'package:telusur_bogor/main_menu/home/tempat/data/repository/firestore_place_repo.dart';
import 'package:telusur_bogor/main_menu/home/homepage/presentation/cubit/tempat_cubit.dart';
import 'package:telusur_bogor/main_menu/home/tempat/presentation/cubit/list_tempat_cubit.dart';
import 'package:telusur_bogor/main_menu/main_menu_page.dart';
import 'package:telusur_bogor/main_menu/map/data/repository/json_map_marker_repo.dart';
import 'package:telusur_bogor/main_menu/map/presentation/cubit/map_marker_cubit/map_marker_cubit.dart';
import 'package:telusur_bogor/main_menu/map/presentation/cubit/search_location_cubit/search_location_cubit.dart';
import 'package:telusur_bogor/main_menu/me/data/repository/firestore_profile_repo.dart';
import 'package:telusur_bogor/main_menu/me/data/repository/firestore_saved_places_repo.dart';
import 'package:telusur_bogor/main_menu/me/data/repository/firestore_tripboard_repo.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/saved_places_cubit/saved_places_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/tripboard_cubit/tripboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final apiWeatherRepo = ApiWeatherRepo();
  final firestorePlaceRepo = FirestorePlaceRepo();
  final firestoreUserRepo = FirestoreUserRepo();
  final firestoreProfileRepo = FirestoreProfileRepo();
  final firestoreSavedPlacesRepo = FirestoreSavedPlacesRepo();
  final firestoreTripboardRepo = FirestoreTripboardRepo();
  final jsonMapMarkerRepo = JsonMapMarkerRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => RouteCubit()),
        // BlocProvider(create: (context) => CurrentPositionCubit()),
        BlocProvider(create: (context) => WeatherCubit(apiWeatherRepo)),
        BlocProvider(create: (context) => TempatHomeCubit(firestorePlaceRepo)),
        BlocProvider(create: (context) => ListTempatCubit(firestorePlaceRepo)),
        BlocProvider(create: (context) => AuthCubit(firestoreUserRepo)),
        BlocProvider(create: (context) => ProfileCubit(firestoreProfileRepo)),
        BlocProvider(
          create: (context) => SavedPlacesCubit(firestoreSavedPlacesRepo),
        ),
        BlocProvider(
          create: (context) => TripboardCubit(firestoreTripboardRepo),
        ),
        BlocProvider(create: (context) => MapMarkerCubit(jsonMapMarkerRepo)),
        BlocProvider(create: (context) => SearchCubit()),
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
      title: 'Telusur Bogor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: mainColor,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: mainColor),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: mainColor),
      ),
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const MainMenuPage();
          } else if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const Loginorregister();
          }
        },
      ),
    );
  }
}
