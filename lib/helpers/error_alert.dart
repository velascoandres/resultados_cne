part of 'helpers.dart';

void errorAlert(BuildContext context, String mensaje) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ha ocurrido un problema'),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('$mensaje'),
        ),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Ha ocurrido un problema'),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('$mensaje'),
        ),
      ),
    );
  }
}
