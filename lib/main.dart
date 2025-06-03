import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/dashboardScreen/DashboardScreen.dart';
import 'package:untitled/screens/HplScreen.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';
import 'package:untitled/screens/LoginScreen.dart';
import 'package:untitled/screens/MobileUserScreen.dart';
import 'package:untitled/screens/RegisterBioScreen.dart';
import 'package:untitled/screens/registerScreen/RegisterEmailScreen.dart';
import 'package:untitled/screens/RegisterFixScreen.dart';
import 'package:untitled/screens/RegisterScreen.dart';
import 'package:untitled/screens/SplashScreen.dart';
import 'package:untitled/screens/registerScreen/RegisterEmailVerificationScreen.dart';
import 'package:untitled/screens/registerScreen/RegisterPasswordScreen.dart';
import 'package:untitled/screens/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('id', 'ID'),
      ],
      routes: {
        '/login': (context) => LoginScreen(),
        '/login-fix': (context) => LoginFixScreen(),
        '/register': (context) => RegisterScreen(),
        '/register-fix': (context) => RegisterFixScreen(),
        '/register-email': (context) => RegisterEmailScreen(),
        '/register-email-verification': (context) => RegisterEmailVerificationScreen(),
        '/register-bio': (context) => RegisterBioScreen(),
        '/register-password': (context) => RegisterPasswordScreen(),
        '/mobile-user': (context) => MobileUserScreen(),
        '/hpl': (context) => Hplscreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
      home: SplashScreen(),
    );
  }
}
