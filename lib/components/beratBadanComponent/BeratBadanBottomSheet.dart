import 'package:flutter/material.dart';
import 'package:untitled/components/beratBadanComponent/BeratBadanDialog.dart';
import 'package:untitled/controller/BeratBadanController.dart';
import 'package:untitled/models/beratbadan/BeratBadan.dart';

class BeratBadanModalBottomSheet extends StatefulWidget {
  final BeratBadan beratBadan;

  BeratBadanModalBottomSheet({
    required this.beratBadan,
  });

  @override
  _BeratBadanModalBottomSheetState createState() => _BeratBadanModalBottomSheetState();
}

class _BeratBadanModalBottomSheetState extends State<BeratBadanModalBottomSheet> {
  bool isProcessing = false;

  Future<void> refreshData() async {
    List<BeratBadan>? fetchedData = await BeratBadanController.getAllBeratBadan();
    setState(() {
      BeratBadanController.listBeratBadan = fetchedData ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Kelola Catatan',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Edit button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return BeratBadanDialog(
                      parentContext: context,
                      action: 'edit',
                      beratBadan: widget.beratBadan,
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(50, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Delete button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                await BeratBadanController.deleteBeratBadan(widget.beratBadan.idBeratBadan);
                await refreshData();
                Navigator.pop(context, true);
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(50, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hapus',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Cancel button
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Colors.pink[900]!, Colors.pink],
                ),
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: const Size(50, 50),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
