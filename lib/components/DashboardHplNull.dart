import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/components/TextSwitcher.dart';
import 'package:untitled/controller/DataDiriController.dart';
import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/screens/hplScreen/HplChoiceScreen.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';

class DashboardHplNull extends StatefulWidget {
  final Function()? onDataChanged;

  const DashboardHplNull({super.key, this.onDataChanged});

  @override
  State<DashboardHplNull> createState() => _DashboardHplNullState();
}

class _DashboardHplNullState extends State<DashboardHplNull> {

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginFixScreen()),
    );
  }

  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      MobileUserController.getMobileUser(),
      DataDiriController.getAllDataDiri(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String displayName = "";

    if (DataDiriController.dataDiri != null) {
      displayName = DataDiriController.dataDiri!.namaLengkap;
    } else if (MobileUserController.mobileUser != null) {
      displayName = MobileUserController.mobileUser!.email;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Halo, ' + displayName,
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
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[900]!, Colors.pink],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              hoverColor: Colors.grey[100],
                              splashColor: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HplChoiceScreen(onDataChanged: widget.onDataChanged)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/logo.png',
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        'Informasi Kehamilan',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink[900],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Center(
                                      child: TextSwitcher(
                                        texts: [
                                          "Apakah Anda belum mengetahui HPL Anda?",
                                          "Atau, Sudah mengetahuinya?",
                                        ],
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Center(
                                      child: TextSwitcher(
                                        texts: [
                                          "Ayo hitung HPL Anda",
                                          "Coba masukkan HPL Anda",
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: FilledButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(MaterialState.hovered)) {
                                                  return Colors.pink[400];
                                                }
                                                return Colors.pink[600];
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HplChoiceScreen(onDataChanged: widget.onDataChanged)),
                                            );
                                          },
                                          child: Text(
                                            'Tekan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

          return Center(child: Text('No Data Available'));
        },
      ),
    );
  }
}
