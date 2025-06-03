import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controller/HplController.dart';
import 'package:untitled/models/hpl/Hpl.dart';

class HplDialog extends StatefulWidget {
  final BuildContext parentContext;
  final String action;
  final Hpl? hpl;

  const HplDialog({
    Key? key,
    required this.parentContext,
    required this.action,
    this.hpl,
  }) : super(key: key);

  @override
  _HplDialogState createState() => _HplDialogState();
}

class _HplDialogState extends State<HplDialog> {
  late TextEditingController _tanggalController;
  late String sendTanggal;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: Locale('id', 'ID'),
      initialDate: HplController.hpl?.hpl ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 280)),
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
      final editedTanggal = DateFormat('dd MMMM yyyy', 'id_ID').format(picked).toString();
      sendTanggal = DateFormat('yyyy-MM-dd').format(picked).toString();
      _tanggalController.text = editedTanggal;
    }
  }

  Future<void> _actionHpl(String action, Hpl? hpl) async {
    if (action == 'add' && hpl == null) {
      if (_tanggalController.text.isNotEmpty) {
        try {
          await HplController.createHplByDate(sendTanggal);
          await refreshData();
          Navigator.pop(context, true);
          Navigator.pop(context, true);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menambahkan data')),
          );
        }
      }
    } else if (action == 'edit') {
      try {
        await HplController.updateHplByDate(hpl!.idHpl, sendTanggal);
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
        await HplController.deleteHpl(hpl!.idHpl);
        await refreshData();
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus data')),
        );
      }
    }
  }

  String tanggalLahirFormat(DateTime mysqlDate) {
    DateTime localDate = mysqlDate.toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(localDate);

    return formattedDate;
  }

  Future<void> refreshData() async {
    Hpl? fetchedData = await HplController.getHpl();
    setState(() {
      HplController.hpl = fetchedData ?? null;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.hpl != null) {
      final editedTanggal = tanggalLahirFormat(widget.hpl!.hpl).toString();
      sendTanggal = DateFormat('yyyy-MM-dd').format(widget.hpl!.hpl).toString();
      _tanggalController = TextEditingController(text: editedTanggal);
    } else {
      _tanggalController = TextEditingController();
    }
  }

  @override
  void dispose() {
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
        (widget.action == 'add') ? 'Tambah Data HPL' : 'Edit Data HPL',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _tanggalController,
            decoration: InputDecoration(
              labelText: 'Pilih Tanggal HPL',
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
                      _actionHpl(widget.action, null);
                    } else {
                      _actionHpl(widget.action, widget.hpl);
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
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
