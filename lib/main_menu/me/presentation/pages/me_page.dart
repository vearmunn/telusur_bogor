import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/auth/presentation/cubit/auth_cubit.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/saved_places_cubit/saved_places_cubit.dart';
import 'package:telusur_bogor/main_menu/me/presentation/pages/saved_places_page.dart';
import 'package:telusur_bogor/main_menu/me/presentation/pages/tripboard_page.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  void initState() {
    // context.read<ProfileCubit>().loadProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileError) {
              return Center(child: Text(state.errMessage));
            }
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<AuthCubit>().logout(),
                        child: Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.redAccent),
                              horizontalSpace(8),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  Text(
                    state.profile.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    state.profile.email,
                    style: TextStyle(color: Colors.white),
                  ),
                  verticalSpace(20),
                  _buildMenuOptions(state.profile.uid),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Expanded _buildMenuOptions(String uid) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            _buildOptionTile(
              onTap: () {},
              icon: Icons.edit_outlined,
              title: 'Edit Profile',
            ),
            _buildOptionTile(
              onTap: () {
                context.read<SavedPlacesCubit>().fetchSavedPlaces(uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedPlacesPage(uid: uid),
                  ),
                );
              },
              icon: Icons.bookmark_border_outlined,
              title: 'Saved Places',
            ),
            _buildOptionTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TripboardPage()),
                );
              },
              icon: Icons.category_outlined,
              title: 'My Tripboard',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 231, 231, 231),
              ),
              child: Icon(icon, color: Colors.black54),
            ),
            horizontalSpace(16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
