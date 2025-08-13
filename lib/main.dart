import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/auth/data/repository/firestore_user_repo.dart';
import 'package:telusur_bogor/auth/presentation/cubit/auth_cubit.dart';
import 'package:telusur_bogor/auth/presentation/pages/login_or_register.dart';
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
  final firestoreUserRepo = FirestoreUserRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherCubit(apiWeatherRepo)),
        BlocProvider(create: (context) => TempatHomeCubit(firestorePlaceRepo)),
        BlocProvider(create: (context) => ListTempatCubit(firestorePlaceRepo)),
        BlocProvider(create: (context) => AuthCubit(firestoreUserRepo)),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
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
