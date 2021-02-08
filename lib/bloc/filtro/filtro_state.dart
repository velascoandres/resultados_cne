part of 'filtro_bloc.dart';

@immutable
class FiltroState {
  final int numProvincia;
  final int codDignidad;
  final int codCanton;
  final int codCircunscripcion;

  final ResultResponse resultResponse;

  FiltroState({
    this.numProvincia =  0,
    this.codCircunscripcion = 0,
    this.codDignidad = 1,
    this.codCanton = -1,
    this.resultResponse,
  });

  FiltroState copyWith({
    int numProvincia = -1,
    int codDignidad,
    int codCanton,
    int codCircunscripcion,
    ResultResponse resultResponse,
  }) =>
      FiltroState(
        numProvincia: numProvincia ?? this.numProvincia,
        codCanton: codCanton ?? this.codCanton,
        codCircunscripcion: codCircunscripcion ?? this.codCircunscripcion,
        codDignidad: codDignidad ?? this.codDignidad,
        resultResponse: resultResponse ?? this.resultResponse,
      );
}
