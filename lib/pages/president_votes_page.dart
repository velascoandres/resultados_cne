import 'package:flutter/material.dart';

class PresidentVotesPage extends StatelessWidget {
  const PresidentVotesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados Actuales Presidente-Vicepresidente'),
      ),
      body: Center(
        child: Text('Aqui va el grafico'),
      ),
    );
  }
}
