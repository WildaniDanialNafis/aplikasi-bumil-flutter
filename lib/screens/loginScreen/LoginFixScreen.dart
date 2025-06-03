import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/api/google_signin_api.dart';
import 'package:untitled/controller/LoginController.dart';
import 'package:untitled/screens/forgetPassword/ForgetPasswordEmailScreen.dart';
import 'package:untitled/screens/logged_in_page.dart';
import 'package:untitled/screens/registerScreen/RegisterEmailScreen.dart';
import 'package:untitled/validators/LoginValidator.dart';

class LoginFixScreen extends StatefulWidget {
  const LoginFixScreen({super.key});

  @override
  State<LoginFixScreen> createState() => _LoginFixScreenState();
}

class _LoginFixScreenState extends State<LoginFixScreen> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passwordError;

  Future<void> _validateEmail(String value) async {
    String? emailValidation = await LoginValidator.validateEmail(value);
    setState(() {
      _emailError = emailValidation;
    });
  }

  Future<void> _validatePassword(String value) async {
    String? passwordValidation = await LoginValidator.validateLoginForm("ficabeumrinah@gmail.com",value);
    setState(() {
      _passwordError = passwordValidation;
    });
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Log In Gagal')));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoggedInPage(user: user),
      ));
    }
  }

  Future<void> hapusSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('kode_verif');
    await prefs.remove('idMobileUser');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hapusSesion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Image.asset(
                      'assets/logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailFieldController,
                      cursorColor: Colors.pink,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: Colors.pink.withOpacity(0.1),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      ),
                      onChanged: (value) {
                        _validateEmail(value);
                      },
                      validator: (value) {
                        final result = LoginValidator.initValidateEmail(value);
                        if (result != null) {
                          return result;
                        }
                        if (_emailError != null) {
                          return _emailError;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordFieldController,
                      cursorColor: Colors.pink,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: Colors.pink.withOpacity(0.1),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        _validatePassword(value);
                      },
                      validator: (value) {
                        final result = LoginValidator.initValidatePassword(value);
                        if (result != null) {
                          return result;
                        }
                        if (_passwordError != null) {
                          return _passwordError;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      onPressed: () async {
                        LoginController.login(_emailFieldController.text, _passwordFieldController.text, context);
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: EdgeInsets.zero,
                        overlayColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetPasswordEmailScreen()),
                        );
                      },
                      child: Text('Lupa kata sandi?'),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Colors.pink, width: 1),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterEmailScreen()),
                        );
                      },
                      child: Text('Buat Akun'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
