import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/components/tekananDarahComponent/TekananDarahBottomSheet.dart';
import 'package:untitled/models/tekanandarah/TekananDarah.dart';

class DataTekananDarah extends DataTableSource {
  final List<TekananDarah> data;
  final BuildContext buildContext;
  final Function()? onDataChanged;

  DataTekananDarah(this.data, this.buildContext, this.onDataChanged);

  @override
  DataRow getRow(int index) {
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text(DateFormat('yyyy-MM-dd').format(item.createdAt))),
      DataCell(Text(item.sistolik.toString())),
      DataCell(Text(item.diastolik.toString())),
      DataCell(Row(
        children: [
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: buildContext,
                isScrollControlled: true,
                builder: (context) {
                  return TekananDarahBottomSheet(tekananDarah: item);
                },
              ).then((value) {
                if (onDataChanged != null) {
                  onDataChanged!();
                }
              });
            },
            child: const Icon(Icons.more_vert),
          )
        ],
      )
      ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}