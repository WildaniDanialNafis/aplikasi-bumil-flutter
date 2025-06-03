import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFixScreen extends StatefulWidget {
  const RegisterFixScreen({super.key});

  @override
  State<RegisterFixScreen> createState() => _RegisterFixScreenState();
}

class _RegisterFixScreenState extends State<RegisterFixScreen> {

  final _usernameController = TextEditingController();

  Future<void> saveUsername () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    Navigator.pushReplacementNamed(context, '/register-password');
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
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    Text('Buat Akun',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 32
                      ),
                    ),
                    Text('Masukkan nama Anda',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextField(
                      controller: _usernameController,
                      cursorColor: Colors.black87,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: saveUsername,
                      child: Text('Selanjutnya'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.only(
                          top: 6,
                          bottom: 6,
                          left: 12,
                          right: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
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
