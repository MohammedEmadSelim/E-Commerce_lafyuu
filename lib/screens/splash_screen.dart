import 'package:flutter/material.dart';
import 'package:lafyuu_e_commerce/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>const LoginScreen()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //don't write code here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    return Scaffold(
      backgroundColor: const Color(0xff40bfff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/splash_icon.png'),
          ),
        ],
      ),
    );
  }
}
