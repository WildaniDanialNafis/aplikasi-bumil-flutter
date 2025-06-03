import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:untitled/components/hplComponent/HplDialog.dart';
import 'package:untitled/components/hplComponent/UsiaKehamilanDialog.dart';
import 'package:untitled/controller/HplController.dart';

class HplChoiceScreen extends StatefulWidget {
  final Function()? onDataChanged;
  const HplChoiceScreen({super.key, this.onDataChanged});

  @override
  State<HplChoiceScreen> createState() => _HplChoiceScreenState();
}

class _HplChoiceScreenState extends State<HplChoiceScreen> {
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
      backgroundColor: Colors.pink[50],
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 30),
                Text(
                  'Pilih Metode',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card pertama: Usia Kehamilan
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
                              if (HplController.hpl == null) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return UsiaKehamilanDialog(
                                      parentContext: context,
                                      action: 'add',
                                      hpl: null,
                                    );
                                  },
                                ).then((value) {
                                  if (widget.onDataChanged != null) {
                                    widget.onDataChanged!();
                                  }
                                });
                              } else {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return UsiaKehamilanDialog(
                                      parentContext: context,
                                      action: 'edit',
                                      hpl: HplController.hpl,
                                    );
                                  },
                                ).then((value) {
                                  if (widget.onDataChanged != null) {
                                    widget.onDataChanged!();
                                  }
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 40,
                                      color: Colors.pink[900],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Usia Kehamilan',
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
                    // Card kedua: HPL
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
                              if (HplController.hpl == null) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return HplDialog(
                                      parentContext: context,
                                      action: 'add',
                                      hpl: null,
                                    );
                                  },
                                ).then((value) {
                                  if (widget.onDataChanged != null) {
                                    widget.onDataChanged!();
                                  }
                                });
                              } else {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return HplDialog(
                                      parentContext: context,
                                      action: 'edit',
                                      hpl: HplController.hpl,
                                    );
                                  },
                                ).then((value) {
                                  if (widget.onDataChanged != null) {
                                    widget.onDataChanged!();
                                  }
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 40,
                                      color: Colors.pink[900],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'HPL',
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