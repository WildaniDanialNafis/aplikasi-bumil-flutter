import 'package:flutter/material.dart';
import 'package:untitled/components/beratBadanComponent/DataBeratBadan.dart';
import 'package:untitled/components/beratBadanComponent/FloatingButtonBeratBadan.dart';
import 'package:untitled/controller/BeratBadanController.dart';
import 'package:untitled/models/beratbadan/BeratBadan.dart';
import 'package:fl_chart/fl_chart.dart';

class BeratBadanScreen extends StatefulWidget {
  const BeratBadanScreen({super.key});

  @override
  State<BeratBadanScreen> createState() => _BeratBadanScreenState();
}

class _BeratBadanScreenState extends State<BeratBadanScreen> {
  bool isLoading = true;

  _initialize() async {
    try {
      List<BeratBadan>? fetchedData = await BeratBadanController.getAllBeratBadan();
      setState(() {
        BeratBadanController.listBeratBadan = fetchedData ?? [];
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
                    Text('Grafik Berat Badan', style: TextStyle(color: Colors.pink[700], fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Container(
                      height: 300,
                      child: LineChartBeratBadan(),
                    ),
                  ],
                ),
              ),
              Card(
                child: Container(
                  child: Column(
                    children: [
                      PaginatedDataTable(
                        header: Text('Data Berat Badan', style: TextStyle(color: Colors.pink[700], fontWeight: FontWeight.bold)),
                        columns: const [
                          DataColumn(label: Text('Tanggal')),
                          DataColumn(label: Text('Berat Badan')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        source: DataBeratBadan(BeratBadanController.listBeratBadan, context, _initialize),
                        rowsPerPage: 10,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonBeratBadan(
        onDataChanged: _initialize,
      ),
    );
  }
}

class LineChartBeratBadan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = _getAverageWeightPerMonth();

    if (spots.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.pink.withOpacity(0.5), strokeWidth: 1);
            }),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()} kg',
                      style: TextStyle(color: Colors.pink, fontSize: 12),
                    );
                  },
                  interval: 5,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int monthLabel = value.toInt();
                    return Text(
                      '$monthLabel',
                      style: TextStyle(color: Colors.pink, fontSize: 14),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: true, border: Border.all(color: Colors.pinkAccent, width: 2)),
            lineBarsData: [],
            minY: 0,
            maxY: 100,
            minX: 0,
            maxX: 12,
          ),
        ),
      );
    }

    double minY = spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    double maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 5;

    // Ensure the X axis always starts from 1 and ends at 12
    double minX = 1;
    double maxX = 12;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.pink.withOpacity(0.5), strokeWidth: 1);
          }),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()} kg',
                    style: TextStyle(color: Colors.pink, fontSize: 12),
                  );
                },
                interval: (maxY - minY) / 5,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int monthLabel = value.toInt();
                  return Text(
                    '$monthLabel',
                    style: TextStyle(color: Colors.pink, fontSize: 14),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.pinkAccent, width: 2)),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.pinkAccent,
              dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(radius: 6, color: Colors.pink, strokeWidth: 2, strokeColor: Colors.white);
              }),
            ),
          ],
          minY: minY,
          maxY: maxY,
          minX: minX,
          maxX: maxX,
        ),
      ),
    );
  }

  List<FlSpot> _getAverageWeightPerMonth() {
    Map<int, List<double>> monthlyData = {};

    for (var item in BeratBadanController.listBeratBadan) {
      DateTime updatedAt = item.updatedAt;
      int month = updatedAt.month;

      if (!monthlyData.containsKey(month)) {
        monthlyData[month] = [];
      }
      monthlyData[month]!.add(item.beratBadan.toDouble());
    }

    List<FlSpot> spots = [];
    for (int month = 1; month <= 12; month++) {
      if (monthlyData.containsKey(month)) {
        List<double> weights = monthlyData[month]!;
        double average = weights.reduce((a, b) => a + b) / weights.length;
        spots.add(FlSpot(month.toDouble(), average));
      } else {
        spots.add(FlSpot(month.toDouble(), 0));  // Set to 0 if no data for that month
      }
    }

    return spots;
  }
}











