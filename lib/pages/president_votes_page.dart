import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/widgets/widgets.dart';

class PresidentVotesPage extends StatelessWidget {
  const PresidentVotesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltroBloc, FiltroState>(
      builder: (context, state) {
        // final FiltroBloc filtroBloc = context.read<FiltroBloc>();
        return Scaffold(
          appBar: AppBar(
              title: Text('Resultados Actuales Presidente-Vicepresidente')),
          body: Container(
            child: Column(
              children: [
                ProvinciaSelect(
                  onSelected: (selected) {},
                ),
                _ChartBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
