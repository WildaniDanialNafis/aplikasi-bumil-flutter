import 'package:flutter/material.dart';
import 'package:untitled/components/DashboardHplExist.dart';
import 'package:untitled/components/DashboardHplNull.dart';
import 'package:untitled/controller/HplController.dart';
import 'package:untitled/models/hpl/Hpl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  _initialize() async {
    Hpl? fetchedData = await HplController.getHpl();
    setState(() {
      HplController.hpl = fetchedData ?? null;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (HplController.hpl != null) {
      return DashboardHplExist(hpl: HplController.hpl!, onDataChanged: _initialize,);
    } else {
      return DashboardHplNull(onDataChanged: _initialize);
    }
  }
}
