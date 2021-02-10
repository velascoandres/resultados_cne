import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/helpers/helpers.dart';
import 'package:resultados_cne/models/result_response.dart';
import 'package:resultados_cne/widgets/widgets.dart';

class PresidentVotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();

    return BlocConsumer<FiltroBloc, FiltroState>(
      listener: (context, state) {
        final hasError = state.error;
        if (hasError) {
          errorAlert(context, 'Error al realizar la consulta');
        }
      },
      builder: (context, state) {
        final isLoading = state.loading;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(title: Text('Resultados Actuales Presidente')),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProvinciaSelect(),
                  isLoading
                      ? _Loader()
                      : _ChartBar(
                          collection: state.resultResponse.datos,
                          domainFn: (Dato dato) =>
                              [dato.strNomCandidato, dato.intVotos],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChartBar<T> extends StatelessWidget {
  final List<T> collection;

  final Function domainFn;

  _ChartBar({
    @required this.collection,
    @required this.domainFn,
  });

  @override
  Widget build(BuildContext context) {
    final dataMap = this._createSeries();

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: double.infinity,
        height: 550,
        child: dataMap.isNotEmpty
            ? PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 12,
                chartRadius: 200,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                legendOptions: LegendOptions(
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  decimalPlaces: 2,
                  showChartValuesOutside: true,
                ),
              )
            : Container(),
      ),
    );
  }

  Map<String, double> _createSeries() {
    Map<String, double> dataMap = new Map();
    return this.collection.fold(
      dataMap,
      (Map acc, T dato) {
        final tuple = this.domainFn(dato);
        final x = tuple[0];
        final int y = tuple[1];
        acc.putIfAbsent(x, () => y.toDouble());
        return acc;
      },
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
