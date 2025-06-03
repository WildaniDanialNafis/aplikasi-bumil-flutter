import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controller/TekananDarahController.dart';
import 'package:untitled/models/tekanandarah/TekananDarah.dart';

class TekananDarahDialog extends StatefulWidget {
  final BuildContext parentContext;
  final String action;
  final TekananDarah? tekananDarah;

  const TekananDarahDialog({
    Key? key,
    required this.parentContext,
    required this.action,
    this.tekananDarah,
  }) : super(key: key);

  @override
  _TekananDarahDialogState createState() => _TekananDarahDialogState();
}

class _TekananDarahDialogState extends State<TekananDarahDialog> {
  late FixedExtentScrollController _sistolikController;
  late FixedExtentScrollController _diastolikController;
  late TextEditingController _tanggalController;
  late String sendTanggal;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pink,
            hintColor: Colors.pink,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: Colors.pink),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final editedTanggal = tanggalFormat(picked);
      sendTanggal = DateFormat('yyyy-MM-dd').format(picked).toString();
      _tanggalController.text = editedTanggal;
    }
  }

  String tanggalFormat(DateTime mysqlDate) {
    DateTime localDate = mysqlDate.toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(localDate);

    return formattedDate;
  }

  Future<void> _actionTekananDarah(String action, TekananDarah? tekananDarah) async {
    if (action == 'add' && tekananDarah == null) {
      if (_tanggalController.text.isNotEmpty) {
        try {
          await TekananDarahController.createTekananDarah(
              _sistolikController.selectedItem + 100, _diastolikController.selectedItem + 60);
          await refreshData();
          Navigator.pop(context, true);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menambahkan data')),
          );
        }
      }
    } else if (action == 'edit') {
      try {
        await TekananDarahController.updateTekananDarah(tekananDarah!.idTekananDarah, _sistolikController.selectedItem + 100, _diastolikController.selectedItem + 60);
        await refreshData();
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah data')),
        );
      }
    } else if (action == 'delete') {
      try {
        await TekananDarahController.deleteTekananDarah(tekananDarah!.idTekananDarah);
        await refreshData();
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus data')),
        );
      }
    }
  }

  Future<void> refreshData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2));

    try {
      List<TekananDarah>? fetchedData = await TekananDarahController.getAllTekananDarah();
      setState(() {
        TekananDarahController.listTekananDarah = fetchedData ?? [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data')),
      );
    } finally {
      Navigator.pop(context);
    }
  }



  @override
  void initState() {
    super.initState();
    if (widget.tekananDarah != null) {
      int sistolik = widget.tekananDarah!.sistolik.toInt();
      int diastolik = widget.tekananDarah!.diastolik.toInt();
      _sistolikController = FixedExtentScrollController(initialItem: (sistolik - 100));
      _diastolikController = FixedExtentScrollController(initialItem: (diastolik - 60));
      final editedTanggal = tanggalFormat(widget.tekananDarah!.updatedAt);
      _tanggalController = TextEditingController(text: editedTanggal);
    } else {
      _sistolikController = FixedExtentScrollController();
      _diastolikController = FixedExtentScrollController();
      _tanggalController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _sistolikController.dispose();
    _diastolikController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust content size to the bottom sheet
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure the content spans the full width
        children: [
          // Title
          Center(
            child: Text(
              'Ubah Data Tekanan Darah',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ListWheelScrollView for systolic and diastolic
          Container(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Sistolik'),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 122,
                        child: ListWheelScrollView.useDelegate(
                          controller: _sistolikController,
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 1.5,
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: Text(
                                  '${100 + index}', // Systolic values
                                  style: const TextStyle(fontSize: 24),
                                ),
                              );
                            },
                            childCount: 101,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '/',
                  style: TextStyle(fontSize: 40),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Diastolik'),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 122,
                        child: ListWheelScrollView.useDelegate(
                          controller: _diastolikController,
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 1.5,
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: Text(
                                  '${60 + index}', // Diastolic values
                                  style: const TextStyle(fontSize: 24),
                                ),
                              );
                            },
                            childCount: 61,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Date Picker
          TextField(
            controller: _tanggalController,
            decoration: InputDecoration(
              labelText: 'Pilih Tanggal',
              labelStyle: TextStyle(
                color: Colors.pink[900], // Slightly darker pink for label
                fontSize: 14,
              ),
              hintText: 'Select date', // Optional: hint text if the field is empty
              hintStyle: TextStyle(
                color: Colors.pink[900], // Light pink for hint text
                fontSize: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.pink[700], // Calendar icon in darker pink
                ),
                onPressed: () {
                  _pickDate(context);
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[200]!), // Lighter pink border when not focused
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[700]!, width: 2), // Darker pink border when focused
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true, // This makes the background color of the TextField
              fillColor: Colors.pink[50], // Very light pink background for the text field
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 50), // Lebar penuh dengan tinggi 50
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.action == 'add') {
                      _actionTekananDarah(widget.action, null);
                    } else {
                      _actionTekananDarah(widget.action, widget.tekananDarah);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[600],
                    minimumSize: Size(100, 50),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
