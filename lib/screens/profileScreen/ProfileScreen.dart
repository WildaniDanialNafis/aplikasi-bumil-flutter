import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/components/alert/CustomAlertDialog.dart';
import 'package:untitled/components/profileComponent/InfoRowWidget.dart';
import 'package:untitled/controller/DataDiriController.dart';
import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/datadiri/DataDiri.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';
import 'package:untitled/screens/profileScreen/RegisterDataDiriLoginScreen.dart';
import 'package:untitled/screens/profileScreen/UpdateDataDiriScreen.dart';
import 'package:untitled/services/MobileUserService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _rotation = 0.0;
  bool isLoading = false;
  String loadingText = "Loading";
  Timer? _timer;

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

  String tanggalLahirFormat(DateTime mysqlDate) {
    DateTime localDate = mysqlDate.toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(localDate);

    return formattedDate;
  }

  void _startLoadingText() {
    int dotCount = 1;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          loadingText = "Loading" + "." * dotCount;
          dotCount = (dotCount % 3) + 1;
        });
      }
    });
  }

  Future<void> _toDataDiri() async {
    setState(() {
      isLoading = true;
    });

    _startLoadingText();

    await Future.delayed(Duration(seconds: 2));

    try {

      if (DataDiriController.dataDiri == null) {
        var updatedData = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterDataDiriLoginScreen(),
        ));

        if (updatedData != null && updatedData is DataDiri) {
          setState(() {
            DataDiriController.dataDiri = updatedData;
          });
        }
      } else {
        var updatedData = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => UpdateDataDiriScreen()),
        );

        if (updatedData != null && updatedData is DataDiri) {
          setState(() {
            DataDiriController.dataDiri = updatedData;
          });
        }
      }

      _timer?.cancel();
      setState(() {
        isLoading = false;
        loadingText = "Loading";
      });
    } catch (e) {
      // Tangani error jika terjadi
      _timer?.cancel();
      setState(() {
        isLoading = false;
        loadingText = "Loading";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: AnimatedRotation(
              turns: _rotation,
              duration: Duration(milliseconds: 500),
              child: Icon(Icons.settings, color: Colors.white),
            ),
            onPressed: () async {
              CustomAlertDialog.showSuccessDialog(context, "Yakin ingin keluar?", () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                await prefs.remove('email');
                await prefs.remove('kode_verif');
                await prefs.remove('idMobileUser');
                await MobileUserService.updateToken(MobileUserController.mobileUser!.idMobileUser);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginFixScreen()),
                );
              });
            },
          ),
        ],
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
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              await _toDataDiri();
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
                  Icon(Icons.draw, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  isLoading ? loadingText : 'Perbarui',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pink[900]!, Colors.pink],
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50.0),
                              CircleAvatar(
                                radius: 65.0,
                                backgroundImage: AssetImage('assets/logo.png'),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                (DataDiriController.dataDiri != null)
                                    ? DataDiriController.dataDiri!.namaLengkap
                                    : 'Tidak Ada Data Diri',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                (MobileUserController.mobileUser != null)
                                    ? MobileUserController.mobileUser!.email
                                    : '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.53,
                          ),
                          child: Container(
                            color: Colors.pink[50],
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Informasi Data Diri", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800)),
                                          Divider(color: Colors.grey[300]),
                                          InfoRowWidget(
                                            label: "Nama",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.namaLengkap : 'Tidak Ada Data Diri',
                                            icon: Icons.home,
                                            iconColor: Colors.blueAccent[400],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Email",
                                            value: (MobileUserController.mobileUser != null) ? MobileUserController.mobileUser!.email : '',
                                            icon: Icons.email,
                                            iconColor: Colors.yellowAccent[400],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Tempat Lahir",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.tempatLahir : 'Tidak Ada Data Diri',
                                            icon: Icons.favorite,
                                            iconColor: Colors.pinkAccent[400],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Tanggal Lahir",
                                            value: (DataDiriController.dataDiri != null) ? tanggalLahirFormat(DataDiriController.dataDiri!.tanggaLahir) : 'Tidak Ada Data Diri',
                                            icon: Icons.cake,
                                            iconColor: Colors.blue[200],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Jenis Kelamin",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.jenisKelamin.toString() : 'Tidak Ada Data Diri',
                                            icon: Icons.person,
                                            iconColor: Colors.blue[300],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Provinsi",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.provinsi : 'Tidak Ada Data Diri',
                                            icon: Icons.map,
                                            iconColor: Colors.green[400],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Kabupaten",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.kabupaten : 'Tidak Ada Data Diri',
                                            icon: Icons.location_city,
                                            iconColor: Colors.blue[400],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Alamat",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.alamat : 'Tidak Ada Data Diri',
                                            icon: Icons.location_on,
                                            iconColor: Colors.grey[500],
                                          ),
                                          SizedBox(height: 20.0),
                                          InfoRowWidget(
                                            label: "Nomor Telepon",
                                            value: (DataDiriController.dataDiri != null) ? DataDiriController.dataDiri!.nomorTelepon : 'Tidak Ada Data Diri',
                                            icon: Icons.phone,
                                            iconColor: Colors.green[400],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          }

          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}

