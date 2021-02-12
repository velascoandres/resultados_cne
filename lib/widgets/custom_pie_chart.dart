part of 'widgets.dart';

class CustomPieChart<T> extends StatefulWidget {
  final List<T> collection;
  final Function getTitlesFn;
  final Function getValuesFn;

  const CustomPieChart(
      {Key key, this.collection, this.getTitlesFn, this.getValuesFn})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomPierChartState();
}

class CustomPierChartState extends State<CustomPieChart> {
  int touchedIndex;

  get total => widget.collection
      .fold<int>(0, (int acc, dato) => acc + widget.getValuesFn(dato));

  @override
  Widget build(BuildContext context) {
  
      return SingleChildScrollView(
              child: Column(
          children: <Widget>[
            PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
            ..._buildIndicators(),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      );
  }

  List<Widget> _buildIndicators() {
    final collectionMap = this.widget.collection.asMap();
    return collectionMap.keys.map(
      (dataKey) {
        final data = collectionMap[dataKey];
        final title = this.widget.getTitlesFn(data);
        return Indicator(
          text: title,
          isSquare: true,
          color: AVALAIBLE_COLORS[dataKey],
        );
      },
    ).toList();
  }

  List<PieChartSectionData> showingSections() {
    final collectionMap = this.widget.collection.asMap();
    return collectionMap.keys.map(
      (dataKey) {
        final isTouched = dataKey == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        final data = collectionMap[dataKey];
        final value = this.widget.getValuesFn(data).toDouble();
        final percent = ((value * 100) / total).toStringAsFixed(2);
        return PieChartSectionData(
          color: AVALAIBLE_COLORS[dataKey],
          value: value,
          title: '$percent %',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: isTouched ? Colors.white : Colors.black
          ),
        );
      },
    ).toList();
  }
}
