import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:healthview/Data/models.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class BloodPressureLineChart extends StatefulWidget {
  @override
  _BloodPressureLineChartState createState() => _BloodPressureLineChartState();
}

class _BloodPressureLineChartState extends State<BloodPressureLineChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
            aspectRatio: 3.5 / 2, // Height: 3 Width: 2
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18, left: 12, top: 24, bottom: 12),
                child: LineChart(yearToDate()),
              ),
            )
        )
      ],
    );
  }

  LineChartData yearToDate() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 12,
          textStyle:
          const TextStyle(color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'FEB';
              case 3:
                return 'APR';
              case 5:
                return 'JUN';
              case 7:
                return 'AUG';
              case 9:
                return 'OCT';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '50';
              case 1:
                return '75';
              case 2:
                return '100';
              case 3:
                return '125';
              case 4:
                return '150';
              case 5:
                return '175';
              case 6:
                return '200';
            }
            return '';
          },
          reservedSize: 24,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots:
          [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }

  Future<List<FlSpot>> convertData() async {
    List<BloodPressureEntry> entries = await BloodPressureEntry().selectAll();
    List<FlSpot> spots = [];

    for(BloodPressureEntry entry in entries) {
      double myNum = entry.entryDate.month + entry.entryDate.day/28;
      spots.add(new FlSpot(myNum,entry.systolic.toDouble()));
    }

    return spots;
  }
}
