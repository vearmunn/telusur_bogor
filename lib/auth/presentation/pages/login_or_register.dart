import 'package:flutter/material.dart';
import 'package:telusur_bogor/auth/presentation/pages/login_page.dart';
import 'package:telusur_bogor/auth/presentation/pages/register_page.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool isLoginPage = true;
  void togglepage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(togglePage: togglepage);
    } else {
      return RegisterPage(togglePage: togglepage);
    }
  }
}
