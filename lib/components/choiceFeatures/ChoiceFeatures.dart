import 'package:flutter/material.dart';
import 'package:untitled/screens/beratBadanScreen/BeratBadanScreen.dart';
import 'package:untitled/screens/tekananDarahScreen/TekananDarahScreen.dart';

class ChoiceFieturesScreen extends StatefulWidget {
  const ChoiceFieturesScreen({super.key});

  @override
  State<ChoiceFieturesScreen> createState() => _ChoiceFieturesScreenState();
}

class _ChoiceFieturesScreenState extends State<ChoiceFieturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[900]!, Colors.pink],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Menjaga jarak tetap dekat
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 30),
                Text(
                  'Pilih Fitur',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30), // Mengurangi jarak antara teks dan tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BeratBadanScreen(),
                              ));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.accessibility,
                                      size: 40,
                                      color: Colors.pink[900],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Berat Badan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TekananDarahScreen(),
                              ));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: Colors.pink[900],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Tekanan Darah',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
