// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/main_menu/me/presentation/cubit/profile_cubit/profile_cubit.dart';

import 'package:telusur_bogor/widgets/spacer.dart';

import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.togglePage});

  final VoidCallback togglePage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: const CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    await context.read<AuthCubit>().login(
                      emailCtrl.text,
                      passCtrl.text,
                    );
                    context.read<ProfileCubit>().loadProfile();
                  },
                  child: const Text("Login"),
                ),
                verticalSpace(20),
                TextButton(
                  onPressed: widget.togglePage,
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
