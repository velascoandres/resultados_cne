part of 'filtro_bloc.dart';

@immutable
abstract class FiltroEvent {}



class OnProvinciaChange  extends FiltroEvent {

  final int numProvincia;

  OnProvinciaChange(this.numProvincia);
}

