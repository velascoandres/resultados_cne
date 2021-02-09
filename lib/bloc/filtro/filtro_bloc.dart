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
      yield this.state.copyWith(
            numProvincia: event.numProvincia,
            loading: true,
            error: false,
          );

      try {
        final resultResponse = await this.cneService.getVotes(
              numProvincia: event.numProvincia,
              codCanton: this.state.codCanton,
              codCircunscripcion: this.state.codCircunscripcion,
              codDignidad: this.state.codDignidad,
            );

        final newState = this.state.copyWith(
              numProvincia: event.numProvincia,
              resultResponse: resultResponse,
              loading: false,
              error: false,
            );

        yield newState;
      } catch (e) {
        print(e);
        yield this.state.copyWith(
              numProvincia: event.numProvincia,
              loading: false,
              error: true,
              resultResponse: ResultResponse(datos: []),
            );
      }
    }
  }
}
