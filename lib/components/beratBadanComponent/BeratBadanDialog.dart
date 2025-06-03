import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controller/BeratBadanController.dart';
import 'package:untitled/models/beratbadan/BeratBadan.dart';

class BeratBadanDialog extends StatefulWidget {
  final BuildContext parentContext;
  final String action;
  final BeratBadan? beratBadan;

  const BeratBadanDialog({
    Key? key,
    required this.parentContext,
    required this.action,
    this.beratBadan,
  }) : super(key: key);

  @override
  _BeratBadanDialogState createState() => _BeratBadanDialogState();
}

class _BeratBadanDialogState extends State<BeratBadanDialog> {
  late FixedExtentScrollController _controllerLeft;
  late FixedExtentScrollController _controllerRight;
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

  Future<void> _actionBeratBadan(String action, BeratBadan? beratBadan) async {
    if (action == 'add' && beratBadan == null) {
      if (_tanggalController.text.isNotEmpty) {
        try {
          await BeratBadanController.createBeratBadan(
              _controllerLeft.selectedItem + 30, _controllerRight.selectedItem);
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
        await BeratBadanController.updateBeratBadan(beratBadan!.idBeratBadan, _controllerLeft.selectedItem + 30, _controllerRight.selectedItem);
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
        await BeratBadanController.deleteBeratBadan(beratBadan!.idBeratBadan);
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

    // Add a delay of 2 seconds before continuing the data fetching
    await Future.delayed(Duration(seconds: 2));

    try {
      List<BeratBadan>? fetchedData = await BeratBadanController.getAllBeratBadan();
      setState(() {
        BeratBadanController.listBeratBadan = fetchedData ?? [];
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
    if (widget.beratBadan != null) {
      int intPart = widget.beratBadan!.beratBadan.toInt();
      int doublePart = ((widget.beratBadan!.beratBadan - intPart) * 10).round();
      _controllerLeft = FixedExtentScrollController(initialItem: (intPart - 30));
      _controllerRight = FixedExtentScrollController(initialItem: (doublePart));
      final editedTanggal = tanggalFormat(widget.beratBadan!.updatedAt);
      _tanggalController = TextEditingController(text: editedTanggal);
    } else {
      _controllerLeft = FixedExtentScrollController();
      _controllerRight = FixedExtentScrollController();
      _tanggalController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controllerLeft.dispose();
    _controllerRight.dispose();
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ubah Data Berat Badan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          // ListWheelScrollView for berat badan
          Container(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListWheelScrollView.useDelegate(
                      controller: _controllerLeft,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 1.5,
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(
                            child: Text(
                              '${30 + index}', // Berat badan utama
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        childCount: 201,
                      ),
                    ),
                  ),
                ),
                const Text(
                  '.',
                  style: TextStyle(fontSize: 40),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListWheelScrollView.useDelegate(
                      controller: _controllerRight,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 1.5,
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(
                            child: Text(
                              '$index', // Berat badan desimal
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        childCount: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _tanggalController,
            decoration: InputDecoration(
              labelText: 'Pilih Tanggal',
              labelStyle: TextStyle(
                color: Colors.pink[900],
                fontSize: 14,
              ),
              hintText: 'Select date',
              hintStyle: TextStyle(
                color: Colors.pink[900],
                fontSize: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.pink[700],
                ),
                onPressed: () {
                  _pickDate(context);
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[200]!),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[700]!, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.pink[50],
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 50),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[600],
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () async {
                    if (widget.action == 'add') {
                      _actionBeratBadan(widget.action, null);
                    } else {
                      _actionBeratBadan(widget.action, widget.beratBadan);
                    }
                  },
                  child: Container(
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
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
