part of 'filtro_bloc.dart';



@immutable
class FiltroState {
  final int numProvincia;
  final int codDignidad;
  final int codCanton;
  final int codCircunscripcion;
  final bool loading;
  final bool error;

  final ResultResponse resultResponse;

   FiltroState({
    this.numProvincia =  -1,
    this.codCircunscripcion = -1,
    this.codDignidad = 1,
    this.codCanton = -1,
    this.resultResponse =  const ResultResponse(datos: []),
    this.loading = false,
    this.error = false,
  });

  FiltroState copyWith({
    int numProvincia,
    int codDignidad,
    int codCanton,
    int codCircunscripcion,
    ResultResponse resultResponse,
    bool loading,
    bool error,
  }) =>
      FiltroState(
        numProvincia: numProvincia ?? this.numProvincia,
        codCanton: codCanton ?? this.codCanton,
        codCircunscripcion: codCircunscripcion ?? this.codCircunscripcion,
        codDignidad: codDignidad ?? this.codDignidad,
        resultResponse: resultResponse ?? this.resultResponse,
        error: error ?? this.error,
        loading: loading ?? this.loading,
      );


  FiltroState startLoading(){
   return  FiltroState(
        loading: true,
        error: false,
    );
  }

  FiltroState stopLoading(){
   return  FiltroState(
        loading: true,
        error: false,
    );
  }
}
