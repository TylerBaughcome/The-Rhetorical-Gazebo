import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazeboemployee/utilities/localStorage.dart' as localStorage;
import "package:http/http.dart" as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_svg/flutter_svg.dart";
import "dart:convert";
import "./googleapi/auth.dart";
import "./googleapi/drive.dart";
import "./auth/login.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  saveTokenToLocalStorage();
  runApp(const MaterialApp(home: Startscreen()));
}

class Startscreen extends StatefulWidget {
  const Startscreen({Key? key}) : super(key: key);

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen>
    with TickerProviderStateMixin {
  late Timer timer;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _visible = false;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: FadeTransition(
          opacity: _animation,
          child: Image.asset("assets/GazeboSplash.png", scale: 3.2),
        )));
  }
}
