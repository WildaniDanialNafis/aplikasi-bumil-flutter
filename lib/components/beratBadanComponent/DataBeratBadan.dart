import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/components/beratBadanComponent/BeratBadanBottomSheet.dart';
import 'package:untitled/models/beratbadan/BeratBadan.dart';

class DataBeratBadan extends DataTableSource {
  final List<BeratBadan> data;
  final BuildContext buildContext;
  final Function()? onDataChanged;

  DataBeratBadan(this.data, this.buildContext, this.onDataChanged);

  @override
  DataRow getRow(int index) {
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text(DateFormat('yyyy-MM-dd').format(item.createdAt))),
      DataCell(Text(item.beratBadan.toString())),
      DataCell(Row(
        children: [
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: buildContext,
                isScrollControlled: true,
                builder: (context) {
                  return BeratBadanModalBottomSheet(beratBadan: item);
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