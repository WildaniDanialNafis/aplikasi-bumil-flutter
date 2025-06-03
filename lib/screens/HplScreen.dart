import 'package:flutter/material.dart';
import 'package:untitled/controller/HplController.dart';
import 'package:untitled/models/hpl/Hpl.dart';

class Hplscreen extends StatefulWidget {
  const Hplscreen({super.key});

  @override
  State<Hplscreen> createState() => _HplscreenState();
}

class _HplscreenState extends State<Hplscreen> {
  final _usiaMingguController = TextEditingController();
  final _usiaHariController = TextEditingController();
  final _hplController = TextEditingController();

  bool _isLoading = false;

  void _getMobileUser() async {
    setState(() {
      _isLoading = true;
    });
    Hpl? response =  await HplController.getHpl();
    setState(() {
      _hplController.text = response!.hpl.toString();
      _usiaMingguController.text = response!.usiaMinggu.toString();
      _usiaHariController.text = response!.usiaHari.toString();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tekanan Darah')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _hplController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Hpl',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usiaMingguController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Usia Minggu',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usiaHariController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Usia Hari',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _getMobileUser,
                child: _isLoading ? CircularProgressIndicator() : Text('Get HPL'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int usiaMinggu = int.tryParse(_usiaMingguController.text) ?? 0;
                  int usiaHari = int.tryParse(_usiaHariController.text) ?? 0;
                  HplController.createHplByUsia(usiaMinggu, usiaHari);
                },
                child: Text('Tambah HPL By Usia'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  DateTime hpl = _hplController.text as DateTime;
                  HplController.createHplByDate(hpl.toString());
                },
                child: Text('Tambah HPL By Date'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int usiaMinggu = int.tryParse(_usiaMingguController.text) ?? 0;
                  int usiaHari = int.tryParse(_usiaHariController.text) ?? 0;
                  HplController.updateHplByUsia(1, usiaMinggu, usiaHari);
                },
                child: Text('Update HPL By Usia'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String hplString = _hplController.text;
                  HplController.updateHplByDate(1, hplString);
                },
                child: Text('Update HPL By Date'),
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int usiaMinggu = int.tryParse(_usiaMingguController.text) ?? 0;
                  int usiaHari = int.tryParse(_usiaHariController.text) ?? 0;
                  HplController.deleteHpl(22);
                },
                child: Text('Delete HPL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
