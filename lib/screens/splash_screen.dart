import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String? get id => null;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    var d = Duration(seconds: 2);
    Future.delayed(d,(){
      if (!mounted){
        return;
      }
      context.goNamed(LoginScreen.routeName);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Multiverse",
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          ),
        ),
      ),
    );
  }
  

  }
  
  