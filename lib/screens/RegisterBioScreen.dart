import 'package:flutter/material.dart';

class RegisterBioScreen extends StatefulWidget {
  const RegisterBioScreen({super.key});

  @override
  State<RegisterBioScreen> createState() => _RegisterBioScreenState();
}

class _RegisterBioScreenState extends State<RegisterBioScreen> {
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
                    Text('Masukkan email Anda',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextField(
                      // controller: _emailController,
                      cursorColor: Colors.black87,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
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
                    TextField(
                      // controller: _emailController,
                      cursorColor: Colors.black87,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Bio',
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
                      onPressed: () => {},
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
