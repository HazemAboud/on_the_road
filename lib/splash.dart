import 'package:flutter/material.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/fuel.png', scale: 1.5,),
          SizedBox(height: 20),
          Text('On The Road',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10),
          CircularProgressIndicator(),
        ],
      ),
      )
    );
  }
}