import 'package:meta/meta.dart';

class Place {
  final String name;
  final int code;
  final int fatherPlace;
  final List<Place> children;

  Place({@required this.name, @required this.code, this.fatherPlace, this.children});
}