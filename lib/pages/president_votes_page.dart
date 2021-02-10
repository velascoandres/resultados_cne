import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/helpers/helpers.dart';
import 'package:resultados_cne/models/result_response.dart';
import 'package:resultados_cne/widgets/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
                          domainFn: (Dato dato, _) => dato.strNomCandidato,
                          measureFn: (Dato dato, _) => dato.intVotos,
                          labelFn: (Dato dato, _) => '${dato.intVotos}',
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
  final Function measureFn;
  final Function labelFn;

  _ChartBar({
    @required this.collection,
    @required this.domainFn,
    @required this.measureFn,
    @required this.labelFn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      height: 500,
      child: new charts.BarChart(
        this._createSeries(),
        animate: true,
        vertical: false,
      ),
    );
  }

  List<charts.Series<T, String>> _createSeries() {
    final data = this.collection;
    return [
      new charts.Series<T, String>(
        id: 'presidentVotes',
        domainFn: this.domainFn,
        measureFn: this.measureFn,
        data: data,
        labelAccessorFn: this.labelFn,
      )
    ];
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
