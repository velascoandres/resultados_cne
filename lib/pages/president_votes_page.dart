import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/helpers/helpers.dart';
import 'package:resultados_cne/widgets/widgets.dart';

class PresidentVotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final scaffoldKey = new GlobalKey<ScaffoldState>();

    return BlocConsumer<FiltroBloc, FiltroState>(
      listener: (context, state){
        final hasError = state.error;
        if (hasError){
          errorAlert(context, 'Error al realizar la consulta');
        }
      },
      builder: (context, state) {
        final isLoading = state.loading;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              title: Text('Resultados Actuales Presidente')),
          body: Container(
            child: Column(
              children: [
                ProvinciaSelect(
                  onSelected: (selected) {},
                ),
                isLoading ? _Loader() : _ChartBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMessage(BuildContext context){
    final snackBar = SnackBar(content: Text('A ocurrido un error al procesar la consulta'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
