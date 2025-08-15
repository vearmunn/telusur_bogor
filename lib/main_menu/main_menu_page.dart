import 'package:flutter/material.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/main_menu/home/homepage/presentation/homepage.dart';
import 'package:telusur_bogor/main_menu/map/map_view.dart';
import 'package:telusur_bogor/main_menu/me/presentation/pages/me_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final List<Widget> screens = [Homepage(), MePage()];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            ),
        shape: CircleBorder(),
        backgroundColor: mainColor,
        elevation: 3,
        child: Icon(Icons.map, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: mainColor,
        // unselectedItemColor:
        //     ThemeHelper.isDark(context) ? Colors.white24 : Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
