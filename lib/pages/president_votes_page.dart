import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/functions/filter_map.dart';
import 'package:resultados_cne/helpers/helpers.dart';
import 'package:resultados_cne/models/result_response.dart';
import 'package:resultados_cne/widgets/widgets.dart';

class PresidentVotesPage extends StatefulWidget {
  @override
  _PresidentVotesPageState createState() => _PresidentVotesPageState();
}

class _PresidentVotesPageState extends State<PresidentVotesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

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
        final datos = state.resultResponse.datos;
        // final isProvinciaSelected = state.numProvincia != -1;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Resultados Actuales'),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () =>
                    BlocProvider.of<FiltroBloc>(context).add(OnRefresh()),
              ),
            ],
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProvinciaSelect(),
                  // isProvinciaSelected ? CantonSelect() : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Container()
                      : LeaderBoard(
                          collection: datos,
                          deepLevel: 3,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(icon: Icon(Icons.pie_chart_outline_outlined)),
                      Tab(icon: Icon(Icons.bar_chart_outlined)),
                    ],
                  ),

                  isLoading
                      ? _Loader()
                      : _buildTabs(
                          filterReduceResultCollection(datos: datos, top: 3),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabs(List<Dato> datos) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: TabBarView(
        controller: _tabController,
        children: [
          CustomPieChart(
            collection: datos,
            getTitlesFn: (Dato dato) => dato.strNomCandidato,
            getValuesFn: (Dato dato) => dato.intVotos,
          ),
          CustomBarChart(
            collection: datos,
            getTitlesFn: (Dato dato) => dato.strNomCandidato.split(' ')[1],
            getValuesFn: (Dato dato) => dato.intVotos,
          ),
        ],
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 3),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text('Cargando datos...')
          ],
        ),
      ),
    );
  }
}
