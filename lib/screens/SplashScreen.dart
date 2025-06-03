import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/components/navigationBar/CustomNavigationBar.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late String loadingText;
  late Timer _loadingTextTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    loadingText = 'Loading.';
    _startLoadingText();
    _checkLoginStatus();
  }

  void _startLoadingText() {
    _loadingTextTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (loadingText == 'Loading.') {
          loadingText = 'Loading..';
        } else if (loadingText == 'Loading..') {
          loadingText = 'Loading...';
        } else {
          loadingText = 'Loading.';
        }
      });
    });
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CustomNavigationBar(),
        ));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginFixScreen(),
        ));
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _loadingTextTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                'assets/logo.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loadingText,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
