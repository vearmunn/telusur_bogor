import 'package:flutter/material.dart';
import 'package:telusur_bogor/const/colors.dart';
import 'package:telusur_bogor/widgets/spacer.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(30),
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
              'Jane Doe',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(4),
            Text('janedoe@gmail.com', style: TextStyle(color: Colors.white)),
            verticalSpace(20),
            _buildMenuOptions(),
          ],
        ),
      ),
    );
  }

  Expanded _buildMenuOptions() {
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
            _buildOptionTile(icon: Icons.edit_outlined, title: 'Edit Profile'),
            _buildOptionTile(
              icon: Icons.bookmark_border_outlined,
              title: 'Saved Places',
            ),
            _buildOptionTile(
              icon: Icons.category_outlined,
              title: 'My Tripboard',
            ),
          ],
        ),
      ),
    );
  }

  Container _buildOptionTile({required IconData icon, required String title}) {
    return Container(
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
              color: const Color.fromARGB(255, 231, 231, 231),
            ),
            child: Icon(icon, color: Colors.black54),
          ),
          horizontalSpace(16),
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(Icons.keyboard_arrow_right, color: Colors.black54),
        ],
      ),
    );
  }
}
