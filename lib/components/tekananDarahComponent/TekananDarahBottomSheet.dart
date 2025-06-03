import 'package:flutter/material.dart';
import 'package:untitled/components/tekananDarahComponent/TekananDarahDialog.dart';
import 'package:untitled/controller/TekananDarahController.dart';
import 'package:untitled/models/tekanandarah/TekananDarah.dart';

class TekananDarahBottomSheet extends StatefulWidget {
  final TekananDarah tekananDarah;

  TekananDarahBottomSheet({
    required this.tekananDarah,
  });

  @override
  _TekananDarahBottomSheetState createState() => _TekananDarahBottomSheetState();
}

class _TekananDarahBottomSheetState extends State<TekananDarahBottomSheet> {
  bool isProcessing = false;

  Future<void> refreshData() async {
    List<TekananDarah>? fetchedData = await TekananDarahController.getAllTekananDarah();
    setState(() {
      TekananDarahController.listTekananDarah = fetchedData ?? [];
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
                    return TekananDarahDialog(
                      parentContext: context,
                      action: 'edit',
                      tekananDarah: widget.tekananDarah,
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
                await TekananDarahController.deleteTekananDarah(widget.tekananDarah.idTekananDarah);
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
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size(50, 50),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
