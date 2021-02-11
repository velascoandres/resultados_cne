import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultados_cne/bloc/filtro/filtro_bloc.dart';
import 'package:resultados_cne/pages/president_votes_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FiltroBloc()..add(OnProvinciaChange(-1)),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // other properties...
        ),
        themeMode: ThemeMode.dark,
        initialRoute: 'president-votes',
        routes: {
          'president-votes': (_) => PresidentVotesPage(),
        },
      ),
    );
  }
}
