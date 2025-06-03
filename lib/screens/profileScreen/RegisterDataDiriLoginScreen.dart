import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/components/alert/CustomAlertDialog.dart';
import 'package:untitled/controller/DataDiriController.dart';
import 'package:untitled/controller/KabupatenController.dart';
import 'package:untitled/controller/ProvinsiController.dart';
import 'package:untitled/models/kabupaten/Kabupaten.dart';
import 'package:untitled/models/provinsi/Provinsi.dart';
import 'package:untitled/validators/RegisterDataDiriValidator.dart';

class RegisterDataDiriLoginScreen extends StatefulWidget {
  const RegisterDataDiriLoginScreen({super.key});

  @override
  State<RegisterDataDiriLoginScreen> createState() => _RegisterDataDiriLoginScreenState();
}

class _RegisterDataDiriLoginScreenState extends State<RegisterDataDiriLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingGender = false;
  bool isLoadingProvinsi = false;
  bool isLoadingKabupaten = false;

  final _namaLengkapController = TextEditingController();
  final _tempatLahirController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _nomorTeleponController = TextEditingController();

  ValueNotifier<String?> _selectedGenderNotifier = ValueNotifier<String?>(null);
  ValueNotifier<String?> _selectedProvinsiNotifier = ValueNotifier<String?>(null);
  ValueNotifier<String?> _selectedKabupatenNotifier = ValueNotifier<String?>(null);

  String loadingText = "Loading";
  Timer? _timer;

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

  _initialize() async {
    if (ProvinsiController.listProvinsi.isEmpty) {
      setState(() {
        isLoadingProvinsi = true;
      });
      try {
        var result = await ProvinsiController.getAllProvinsi();
        setState(() {
          ProvinsiController.listProvinsi = result ?? [];
          isLoadingProvinsi = false;
        });
      } catch (e) {
        setState(() {
          isLoadingProvinsi = false;
        });
      }
    }

    if (KabupatenController.listKabupaten.isEmpty) {
      setState(() {
        isLoadingKabupaten = true;
      });
      try {
        var nama = ProvinsiController.listProvinsi.firstWhere((prov) => prov.name == _selectedProvinsiNotifier.value);
        var result = await KabupatenController.getAllKabupaten(nama.code);
        setState(() {
          KabupatenController.listKabupaten = result ?? [];
          isLoadingKabupaten = false;
        });
      } catch (e) {
        setState(() {
          isLoadingKabupaten = false;
        });
      }
    }
  }

  Future<void> _createData() async {
    setState(() {
      isLoading = true;
    });

    _startLoadingText();

    await Future.delayed(Duration(seconds: 2));

    try {

      await DataDiriController.createDataDiri(
        _namaLengkapController.text,
        _tempatLahirController.text,
        _tanggalLahirController.text,
        _selectedGenderNotifier.value!,
        _selectedProvinsiNotifier.value!,
        _selectedKabupatenNotifier.value!,
        _alamatController.text,
        _nomorTeleponController.text,
      );

      _timer?.cancel();
      setState(() {
        isLoading = false;
        loadingText = "Loading";
      });

      CustomAlertDialog.showSuccessDialog(context, "Berhasil Membuat Data Diri", () async {
        await DataDiriController.getAllDataDiri();
        Navigator.pop(context);
        Navigator.pop(context, DataDiriController.dataDiri);
      });
    } catch (e) {
      // Tangani error jika terjadi
      _timer?.cancel();
      setState(() {
        isLoading = false;
        loadingText = "Loading";
      });
      CustomAlertDialog.showErrorDialog(context, "Terjadi Kesalahan: $e");
    }
  }

  @override
  void dispose() {
    _selectedGenderNotifier.dispose();
    _selectedProvinsiNotifier.dispose();
    _selectedKabupatenNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await _createData();
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
                  Icon(Icons.draw, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  isLoading ? loadingText : 'Tambahkan',
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
                      'Tambah Data Diri',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    Text(
                      'Masukkan Data Diri',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form( // Menambahkan Form di sini
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        // Nama Lengkap
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Nama Lengkap',
                              style: TextStyle(
                                color: Colors.pinkAccent[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _namaLengkapController,
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
                          validator: (value) => RegisterDataDiriValidator.validateName(value),
                        ),
                        SizedBox(height: 20.0),
                        // Tempat Lahir
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Tempat Lahir',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _tempatLahirController,
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
                          validator: (value) => RegisterDataDiriValidator.validatePlaceOfBirth(value),
                        ),
                        SizedBox(height: 20.0),
                        // Tanggal Lahir
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Tanggal Lahir',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _tanggalLahirController,
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
                          validator: (value) => RegisterDataDiriValidator.validateDateOfBirth(value),
                        ),
                        SizedBox(height: 20.0),
                        // Jenis Kelamin
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        isLoadingGender
                            ? Center(child: CircularProgressIndicator())  // Tampilkan loading saat isLoading true
                            : ValueListenableBuilder<String?>(
                          valueListenable: _selectedGenderNotifier,
                          builder: (context, selectedGender, child) {
                            return DropdownButtonFormField<String>(
                              value: selectedGender,
                              onChanged: (String? newValue) {
                                _selectedGenderNotifier.value = newValue;
                              },
                              items: <String>['Perempuan']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                              validator: (value) => value == null || value.isEmpty ? 'Gender is required' : null,
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        // Provinsi
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Provinsi',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        isLoadingProvinsi
                            ? CircularProgressIndicator()
                            : ValueListenableBuilder<String?>(
                          valueListenable: _selectedProvinsiNotifier,
                          builder: (context, value, child) {
                            return DropdownButtonFormField<String>(
                              value: value ?? "",
                              onChanged: (String? newValue) async {
                                _selectedProvinsiNotifier.value = newValue;
                                var selectedProvinsi = ProvinsiController.listProvinsi
                                    .firstWhere((provinsi) => provinsi.name == newValue);

                                print(selectedProvinsi!.code);

                                // Set status loading kabupaten saat menunggu data
                                setState(() {
                                  isLoadingKabupaten = true;
                                });

                                // Tunggu sampai kabupaten selesai dimuat
                                await KabupatenController.getAllKabupaten(selectedProvinsi.code);
                                _selectedKabupatenNotifier.value = "";

                                // Setelah kabupaten selesai dimuat, set status loading kabupaten menjadi false
                                setState(() {
                                  isLoadingKabupaten = false;
                                });
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: "",
                                  child: Text("Pilih Provinsi"),
                                ),
                                ...ProvinsiController.listProvinsi.map<DropdownMenuItem<String>>(
                                      (Provinsi provinsi) {
                                    return DropdownMenuItem<String>(
                                      value: provinsi.name,
                                      child: Text(provinsi.name),
                                    );
                                  },
                                ).toList(),
                              ],
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
                              validator: (value) => RegisterDataDiriValidator.validateProvince(value),
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Kabupaten',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        isLoadingKabupaten
                            ? CircularProgressIndicator()
                            : ValueListenableBuilder<String?>(
                          valueListenable: _selectedKabupatenNotifier,
                          builder: (context, value, child) {
                            return DropdownButtonFormField<String>(
                              value: value ?? "",
                              onChanged: (String? newValue) {
                                _selectedKabupatenNotifier.value = newValue;
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: "",
                                  child: Text("Pilih Kabupaten"),
                                ),
                                ...KabupatenController.listKabupaten.map<DropdownMenuItem<String>>(
                                      (Kabupaten kabupaten) {
                                    return DropdownMenuItem<String>(
                                      value: kabupaten.name,
                                      child: Text(kabupaten.name),
                                    );
                                  },
                                ).toList(),
                              ],
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
                              validator: (value) => RegisterDataDiriValidator.validateRegency(value),
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        // Alamat
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Alamat',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _alamatController,
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
                          validator: (value) => RegisterDataDiriValidator.validateAddress(value),
                        ),
                        SizedBox(height: 20.0),
                        // No. Telepon
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'No. Telepon',
                            style: TextStyle(
                              color: Colors.pinkAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _nomorTeleponController,
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
                          validator: (value) => RegisterDataDiriValidator.validatePhoneNumber(value),
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
      ),
    );
  }
}