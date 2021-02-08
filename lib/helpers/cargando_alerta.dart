part of 'helpers.dart';

void cargandoAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espera por favor'),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espera por favor'),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
