part of 'widgets.dart';

class CustomBarChart<T> extends StatefulWidget {
  final List<T> collection;

  final Function getTitlesFn;
  final Function getValuesFn;

  CustomBarChart({
    Key key,
    this.collection,
    this.getTitlesFn,
    this.getValuesFn,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomBarChartState<T>();
}

class CustomBarChartState<T> extends State<CustomBarChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  get total => widget.collection
      .fold<int>(0, (int acc, dato) => acc + widget.getValuesFn(dato));

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      widget.collection.asMap().entries.map(
        (data) {
          final int y = widget.getValuesFn(data.value);
          final int x = data.key;
          final barColor = AVALAIBLE_COLORS[x];
          return makeGroupData(x, y.toDouble(),
              isTouched: x == touchedIndex, barColor: barColor);
        },
      ).toList();

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBottomMargin: 20,
          fitInsideVertically: true,
          tooltipPadding: EdgeInsets.all(20),
          tooltipBgColor: Colors.black54,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final data = widget.collection[groupIndex];
            final value = widget.getValuesFn(data);

            final percent = (value * 100) / total;
            final percentFixed = percent.toStringAsFixed(2);

            final title = widget.getTitlesFn(data);

            return BarTooltipItem(
                '$percentFixed % \n  $title', TextStyle(color: Colors.white));
          },
        ),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          rotateAngle: 0,
          getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          margin: 2,
          getTitles: (double value) {
            final index = value.toInt();
            final data = widget.collection[index];
            return widget.getTitlesFn(data);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
