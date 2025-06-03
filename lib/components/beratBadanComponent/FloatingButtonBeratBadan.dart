import 'package:flutter/material.dart';
import 'package:untitled/components/beratBadanComponent/BeratBadanDialog.dart';

class FloatingButtonBeratBadan extends StatelessWidget {
  final Function()? onDataChanged;

  const FloatingButtonBeratBadan({super.key, this.onDataChanged});

  void goToDashboard(BuildContext context) {
    Navigator.pop(context);
  }

  void addBB(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BeratBadanDialog(
          parentContext: context,
          action: 'add',
          beratBadan: null,
        );
      },
    ).then((value) {
      if (onDataChanged != null) {
        onDataChanged!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
          onPressed: () {
              addBB(context);
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

              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Tambahkan',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}