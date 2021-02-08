import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resultados_cne/models/result_response.dart';
import 'package:resultados_cne/services/cne_service.dart';

part 'filtro_event.dart';
part 'filtro_state.dart';

class FiltroBloc extends Bloc<FiltroEvent, FiltroState> {
  final CneService _cneService = new CneService();

  FiltroBloc() : super(FiltroState());

  CneService get cneService => this._cneService;

  @override
  Stream<FiltroState> mapEventToState(FiltroEvent event) async* {
    if (event is OnProvinciaChange) {

      

      final resultResponse = await this.cneService.getVotes(
            numProvincia: event.numProvincia,
            codCanton: this.state.codCanton,
            codCircunscripcion: this.state.codCircunscripcion,
            codDignidad: this.state.codDignidad,
          );

      final newState = this.state.copyWith(
            numProvincia: event.numProvincia,
            resultResponse: resultResponse,
          );

      yield newState;
    }
  }
}
