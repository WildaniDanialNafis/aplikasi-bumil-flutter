import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/controller/RegisterController.dart';
import 'package:untitled/screens/forgetPassword/ForgetEmailVerificationScreen.dart';
import 'package:untitled/validators/ForgetPasswordEmailValidator.dart';
import 'dart:async';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({super.key});

  @override
  State<ForgetPasswordEmailScreen> createState() => _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isLoading = false;
  String loadingText = "Loading";
  Timer? _timer;
  String? _emailError;

  // Fungsi untuk memvalidasi email
  Future<void> _validateEmail(String value) async {
    String? emailValidation = await ForgetPasswordEmailValidator.validate(value);
    setState(() {
      _emailError = emailValidation;
    });
  }

  // Fungsi untuk memulai animasi titik loading
  void _startLoadingText() {
    int dotCount = 1;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        loadingText = "Loading" + "." * dotCount;
        dotCount = (dotCount % 3) + 1;
      });
    });
  }

  // Fungsi untuk mengirim email verifikasi
  Future<void> sendVerificationEmail(String recipientEmail) async {
    setState(() {
      isLoading = true;
    });

    _startLoadingText();

    await Future.delayed(Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);

    await RegisterController.verifyEmail(recipientEmail);

    _timer?.cancel();
    setState(() {
      isLoading = false;
      loadingText = "Loading";
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetEmailVerificationScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Kembali',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await sendVerificationEmail(_emailController.text);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                else
                  Icon(Icons.arrow_forward, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  isLoading ? loadingText : 'Berikutnya',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink[900]!, Colors.pink],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: AssetImage('assets/logo.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Lupa Password',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    Text(
                      'Masukkan email Anda',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black87,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey),
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
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          ),
                          onChanged: (value) {
                            _validateEmail(value);
                          },
                          validator: (value) {
                            final result = ForgetPasswordEmailValidator.initValidate(value);
                            if (result != null) {
                              return result;
                            }
                            if (_emailError != null) {
                              return _emailError;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
