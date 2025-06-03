import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/components/TextSwitcher.dart';
import 'package:untitled/components/dashboardComponent/FloatingDashboardCoba.dart';
import 'package:untitled/controller/DataDiriController.dart';
import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/hpl/Hpl.dart';
import 'package:untitled/screens/hplScreen/HplChoiceScreen.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';

class DashboardHplExist extends StatefulWidget {
  final Hpl hpl;
  final Function()? onDataChanged;

  const DashboardHplExist({super.key, required this.hpl, this.onDataChanged});

  @override
  State<DashboardHplExist> createState() => _DashboardHplExistState();
}

class _DashboardHplExistState extends State<DashboardHplExist> {

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginFixScreen()),
    );
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      MobileUserController.getMobileUser(),
      DataDiriController.getAllDataDiri(),
    ]);
  }

  String tanggalLahirFormat(DateTime mysqlDate) {
    DateTime localDate = mysqlDate.toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(localDate);

    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    Hpl hpl = widget.hpl;
    String formattedDate = tanggalLahirFormat(hpl.hpl);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FutureBuilder(
          future: fetchData(), // Panggil Future untuk mendapatkan displayName
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'Loading...',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            } else if (snapshot.hasData) {
              print(DataDiriController.dataDiri);
              if (DataDiriController.dataDiri != null) {
                return Text(
                  'Halo, ' + DataDiriController.dataDiri!.namaLengkap,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                );
              } else if (MobileUserController.mobileUser != null) {
                return Text(
                  'Halo, ' + MobileUserController.mobileUser!.email,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                );
              } else {
                return Text(
                  'Halo, ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                );// Default jika tidak ada data
              }
            } else {
              return Text(
                'Halo, User', // Fallback jika tidak ada data
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            }
          },
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
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (snapshot.hasData) {
            var data = snapshot.data;
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
                                          "Usia Kehamilan",
                                          "Sisa Waktu Hingga HPL",
                                          "Hari Perkiraan Lahir (HPL)",
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
                                          "Usia berdasarkan (Minggu): ${hpl.usiaMinggu} minggu",
                                          "Sisa berdasarkan (Minggu): ${hpl.sisaMinggu} minggu",
                                          "HPL: ${formattedDate}",
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Center(
                                      child: TextSwitcher(
                                        texts: [
                                          "Usia berdasarkan (Hari): ${hpl.usiaHari} hari",
                                          "Sisa berdasarkan (Hari): ${hpl.sisaHari} hari",
                                          "",
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
                                            'Ubah',
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
