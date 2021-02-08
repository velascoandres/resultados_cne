import 'package:flutter/material.dart';
import 'package:resultados_cne/pages/president_votes_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'president-votes',
      routes: {
        'president-votes': ( _ ) => PresidentVotesPage(),
      },
    );
  }
}
