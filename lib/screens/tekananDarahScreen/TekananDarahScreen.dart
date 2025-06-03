import 'package:flutter/material.dart';
import 'package:untitled/components/tekananDarahComponent/DataTekananDarah.dart';
import 'package:untitled/components/tekananDarahComponent/FloatingButtonTekananDarah.dart';
import 'package:untitled/controller/TekananDarahController.dart';
import 'package:untitled/models/tekanandarah/TekananDarah.dart';
import 'package:fl_chart/fl_chart.dart';

class TekananDarahScreen extends StatefulWidget {
  const TekananDarahScreen({super.key});

  @override
  State<TekananDarahScreen> createState() => _TekananDarahScreenState();
}

class _TekananDarahScreenState extends State<TekananDarahScreen> {
  bool isLoading = true;

  _initialize() async {
    try {
      List<TekananDarah>? fetchedData = await TekananDarahController.getAllTekananDarah();
      setState(() {
        TekananDarahController.listTekananDarah = fetchedData ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load data")));
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Kembali',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.pink[200],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink[900]!, Colors.pink],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Text('Grafik Tekanan Darah', style: TextStyle(color: Colors.pink[700], fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Container(
                      height: 300,
                      child: LineChartBloodPressure(),
                    ),
                  ],
                ),
              ),
              Card(
                child: Container(
                  child: Column(
                    children: [
                      PaginatedDataTable(
                        header: Text('Data Tekanan Darah', style: TextStyle(color: Colors.pink[700], fontWeight: FontWeight.bold)),
                        columns: const [
                          DataColumn(label: Text('Tanggal')),
                          DataColumn(label: Text('Sistolik')),
                          DataColumn(label: Text('Diastolik')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        source: DataTekananDarah(TekananDarahController.listTekananDarah, context, _initialize),
                        rowsPerPage: 10,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonTekananDarah(
        onDataChanged: _initialize,
      ),
    );
  }
}

class LineChartBloodPressure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FlSpot> systolicSpots = _getSystolicSpots();
    List<FlSpot> diastolicSpots = _getDiastolicSpots();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 70,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()} mmHg', style: TextStyle(color: Colors.pink, fontSize: 12));
                },
                interval: 20,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int month = value.toInt();
                  return Text('$month', style: TextStyle(color: Colors.pink, fontSize: 14));
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.pinkAccent, width: 2)),
          lineBarsData: [
            LineChartBarData(
              spots: systolicSpots,
              isCurved: true,
              color: Colors.red,
            ),
            LineChartBarData(
              spots: diastolicSpots,
              isCurved: true,
              color: Colors.blue,
            ),
          ],
          minY: 0,
          maxY: 200,
          minX: 0,
          maxX: 13,  // Set maxX to 12 for 12 months
        ),
      ),
    );
  }

  List<FlSpot> _getSystolicSpots() {
    Map<int, List<double>> monthlySystolicData = {};

    for (var record in TekananDarahController.listTekananDarah) {
      DateTime updatedAt = record.updatedAt;
      int month = updatedAt.month;

      if (!monthlySystolicData.containsKey(month)) {
        monthlySystolicData[month] = [];
      }
      monthlySystolicData[month]!.add(record.sistolik.toDouble());
    }

    List<FlSpot> spots = [];
    for (int month = 1; month <= 12; month++) {
      if (monthlySystolicData.containsKey(month)) {
        List<double> systolicValues = monthlySystolicData[month]!;
        double averageSystolic = systolicValues.reduce((a, b) => a + b) / systolicValues.length;
        spots.add(FlSpot(month.toDouble(), averageSystolic));
      } else {
        spots.add(FlSpot(month.toDouble(), 0));  // No data for this month
      }
    }

    return spots;
  }

  List<FlSpot> _getDiastolicSpots() {
    Map<int, List<double>> monthlyDiastolicData = {};

    for (var record in TekananDarahController.listTekananDarah) {
      DateTime updatedAt = record.updatedAt;
      int month = updatedAt.month;

      if (!monthlyDiastolicData.containsKey(month)) {
        monthlyDiastolicData[month] = [];
      }
      monthlyDiastolicData[month]!.add(record.diastolik.toDouble());
    }

    List<FlSpot> spots = [];
    for (int month = 1; month <= 12; month++) {
      if (monthlyDiastolicData.containsKey(month)) {
        List<double> diastolicValues = monthlyDiastolicData[month]!;
        double averageDiastolic = diastolicValues.reduce((a, b) => a + b) / diastolicValues.length;
        spots.add(FlSpot(month.toDouble(), averageDiastolic));
      } else {
        spots.add(FlSpot(month.toDouble(), 0));  // No data for this month
      }
    }

    return spots;
  }
}



