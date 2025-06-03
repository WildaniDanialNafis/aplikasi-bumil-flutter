import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controller/HplController.dart';
import 'package:untitled/models/hpl/Hpl.dart';

class UsiaKehamilanDialog extends StatefulWidget {
  final BuildContext parentContext;
  final String action;
  final Hpl? hpl;

  const UsiaKehamilanDialog({
    Key? key,
    required this.parentContext,
    required this.action,
    this.hpl,
  }) : super(key: key);

  @override
  _UsiaKehamilanDialogState createState() => _UsiaKehamilanDialogState();
}

class _UsiaKehamilanDialogState extends State<UsiaKehamilanDialog> {
  late FixedExtentScrollController _mingguController;
  late FixedExtentScrollController _hariController;
  late String sendTanggal;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
      final editedTanggal = DateFormat('dd MMMM yyyy').format(picked).toString();
      sendTanggal = DateFormat('yyyy-MM-dd').format(picked).toString();
    }
  }

  Future<void> _actionHpl(String action, Hpl? hpl) async {
    if (action == 'add' && hpl == null) {
      if (_mingguController.selectedItem.isFinite && _hariController.selectedItem.isFinite) {
        try {
          await HplController.createHplByUsia(
              _mingguController.selectedItem, _hariController.selectedItem);
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
        await HplController.updateHplByUsia(hpl!.idHpl, _mingguController.selectedItem, _hariController.selectedItem);
        await refreshData();
        Navigator.pop(context, true);
        Navigator.pop(context, true);
        print(HplController.hpl!.usiaMinggu);
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
      int minggu = widget.hpl!.usiaMinggu.toInt();
      int hari = widget.hpl!.usiaHari.toInt();
      _mingguController = FixedExtentScrollController(initialItem: (minggu));
      _hariController = FixedExtentScrollController(initialItem: (hari));
    } else {
      _mingguController = FixedExtentScrollController();
      _hariController = FixedExtentScrollController();
    }
  }

  @override
  void dispose() {
    _mingguController.dispose();
    _hariController.dispose();
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
            (widget.action == 'add') ? 'Tambah Usia Kehamilan' : 'Edit Usia Kehamilan',
            style: TextStyle(
              color: Colors.pink,
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
                      controller: _mingguController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 1.5,
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(
                            child: Text(
                              '${index}', // Berat badan utama
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        childCount: 41,
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
                      controller: _hariController,
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
                        childCount: 7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
