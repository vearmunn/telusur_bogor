import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/presentation/cubit/weather_cubit.dart';
import 'package:telusur_bogor/main_menu/home/rute_angkot/domain/models/angkot_route.dart';
import 'package:telusur_bogor/main_menu/home/rute_angkot/presentation/angkot_list_page.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/models/place.dart';
import 'package:telusur_bogor/main_menu/home/homepage/presentation/cubit/tempat_cubit.dart';
import 'package:telusur_bogor/main_menu/home/tempat/presentation/pages/list_tempat_page.dart';
import 'package:telusur_bogor/widgets/place_card.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: ListView(
          children: [
            verticalSpace(16),

            _buildWelcomeTexts(),
            verticalSpace(16),

            _buildSearchButton(),
            verticalSpace(20),

            _buildTitle(
              context,
              title: 'Cuaca Saat Ini',
              navigateTo: SizedBox.shrink(),
              iconUrl: 'weather',
              includeButton: false,
            ),
            verticalSpace(12),
            _buildWeatherSection(),
            verticalSpace(30),

            _buildTitle(
              context,
              title: 'Destinasi Populer',
              navigateTo: ListTempatPage(tag: 'Popular'),
              iconUrl: 'popular',
            ),
            verticalSpace(12),
            BlocBuilder<TempatHomeCubit, TempatState>(
              builder: (context, state) {
                if (state is ListTempatLoaded) {
                  return _buildPlaceList(context, state.popularPlaceList!);
                }
                if (state is TempatLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is TempatError) {
                  return Center(child: Text(state.errMessage));
                }
                return SizedBox.shrink();
              },
            ),
            verticalSpace(12),

            _buildTitle(
              context,
              title: 'Dekat Anda',
              navigateTo: ListTempatPage(tag: 'Near Me'),
              iconUrl: 'near-me',
            ),
            verticalSpace(12),
            BlocBuilder<TempatHomeCubit, TempatState>(
              builder: (context, state) {
                if (state is ListTempatLoaded) {
                  return _buildPlaceList(context, state.nearMePlaceList!);
                }
                if (state is TempatLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is TempatError) {
                  return Center(child: Text(state.errMessage));
                }
                return SizedBox.shrink();
              },
            ),
            verticalSpace(12),

            _buildTitle(
              context,
              title: 'Tempat Rahasia',
              navigateTo: ListTempatPage(tag: 'Hidden Gems'),
              iconUrl: 'hidden-gem',
            ),
            verticalSpace(12),
            BlocBuilder<TempatHomeCubit, TempatState>(
              builder: (context, state) {
                if (state is ListTempatLoaded) {
                  return _buildPlaceList(context, state.hiddenGemPlaceList!);
                }
                if (state is TempatLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is TempatError) {
                  return Center(child: Text(state.errMessage));
                }
                return SizedBox.shrink();
              },
            ),
            verticalSpace(12),

            _buildTitle(
              context,
              title: 'Rute Angkot',
              navigateTo: AngkotListPage(),
              iconUrl: 'angkot',
            ),
            verticalSpace(12),
            _buildAngkotRoute(),
            verticalSpace(26),

            _buildTitle(
              context,
              title: 'Kontak Darurat',
              navigateTo: SizedBox.shrink(),
              iconUrl: 'emergency-call',
              includeButton: false,
            ),
            verticalSpace(16),
            _buildEmergencyContactContent(),
            verticalSpace(36),

            _buildTitle(
              context,
              title: 'Bantuan Terdekat',
              navigateTo: SizedBox.shrink(),
              iconUrl: 'urgent-place',
              includeButton: false,
            ),
            verticalSpace(16),
            _buildUrgentPlaceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTexts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang di Bogor',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              Text(
                'Mau Kemana Hari Ini?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          horizontalSpace(12),
          Text('Cari...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWeatherSection() {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is WeatherError) {
          return Center(child: Text(state.message));
        }
        if (state is WeatherLoaded) {
          return Align(
            alignment: Alignment.center,
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.all(16),
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
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(state.weather.cityName),
                    ],
                  ),
                  verticalSpace(12),
                  Text(
                    '${state.weather.temperature.toStringAsFixed(0)}°C',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  Image.network(state.weather.iconUrl),
                  verticalSpace(4),
                  Text(state.weather.condition),
                  verticalSpace(16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Icon(Icons.wind_power),
                        horizontalSpace(6),
                        Text('Angin'),
                        Spacer(),
                        Text(
                          '${state.weather.wind} kph',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Icon(Icons.water_drop_outlined),
                        horizontalSpace(6),
                        Text('Kelembapan'),
                        Spacer(),
                        Text(
                          '${state.weather.humidity}%',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildUrgentPlaceList() {
    return BlocBuilder<TempatHomeCubit, TempatState>(
      builder: (context, state) {
        if (state is ListTempatLoaded) {
          final urgentPlaces = state.urgentPlaceList!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: urgentPlaces.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final place = urgentPlaces[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
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
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              place.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        horizontalSpace(16),
                        Expanded(
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
                              Text(
                                place.description,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, size: 16, color: Colors.grey),
                        horizontalSpace(6),
                        Text(
                          place.address,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        if (state is TempatLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TempatError) {
          return Center(child: Text(state.errMessage));
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildEmergencyContactContent() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        children: [
          Text('Hubungi:', style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text(
            '112',
            style: TextStyle(
              color: mainColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Nomor 112 di Bogor merupakan nomor tunggal panggilan darurat (NTPD) yang bisa dihubungi secara gratis, baik melalui telepon seluler maupun telepon rumah. Nomor ini dirancang untuk memudahkan masyarakat dalam memperoleh bantuan dalam berbagai situasi gawat darurat di wilayah Bogor, baik Kota maupun Kabupaten.',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildAngkotRoute() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: angkotRoutes.length,
      itemBuilder: (BuildContext context, int index) {
        final route = angkotRoutes[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
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
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                child: Text(route.code),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.route,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(4),
                    Text(route.landmarks, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(
    BuildContext context, {
    required String title,
    required Widget navigateTo,
    required String iconUrl,
    bool includeButton = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/$iconUrl.png', width: 24),
              horizontalSpace(8),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (includeButton)
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => navigateTo),
                  ),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 6, 6, 6),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Semua',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    horizontalSpace(4),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceList(BuildContext context, List<Place> placeList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      // color: Colors.red,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        itemCount: placeList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final place = placeList[index];
          // final place =
          //     bogorPlaces.where((place) => place.tag == tag).toList()[index];
          return PlaceCard(
            padding: const EdgeInsets.only(bottom: 80.0, right: 16),
            inVerticalList: false,
            place: place,
          );
        },
      ),
    );
  }
}
