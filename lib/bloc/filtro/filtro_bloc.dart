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
      yield* this._onProvinciaChange(event);
    } else if (event is OnRefresh) {
      yield* this._onRefresh(event);
    } else if (event is OnCantonChange) {
      yield* this._onCantonChange(event);
    }
  }

  Stream<FiltroState> _onProvinciaChange(OnProvinciaChange event) async* {
    yield this.state.updateProvince(event.numProvincia);
    try {
      final resultResponse = await this.cneService.getVotes(
            numProvincia: this.state.numProvincia,
            codCanton: this.state.codCanton,
            codCircunscripcion: this.state.codCircunscripcion,
            codDignidad: this.state.codDignidad,
          );
      yield this.state.updateResultResponse(resultResponse);
    } catch (e) {
      print(e);
      yield this.state.emptyResultResponseError();
    }
  }

  Stream<FiltroState> _onCantonChange(OnCantonChange event) async* {
    yield this.state.updateCanton(event.codCanton);
    try {
      final resultResponse = await this.cneService.getVotes(
            numProvincia: this.state.numProvincia,
            codCanton: event.codCanton,
            codCircunscripcion: this.state.codCircunscripcion,
            codDignidad: this.state.codDignidad,
          );

      final newState = this.state.updateResultResponse(resultResponse);
      yield newState;
    } catch (e) {
      print(e);
      yield this.state.emptyResultResponseError();
    }
  }

  Stream<FiltroState> _onRefresh(OnRefresh event) async* {
    yield this.state.startLoading();
    try {
      final resultResponse = await this.cneService.getVotes(
            numProvincia: this.state.numProvincia,
            codCanton: this.state.codCanton,
            codCircunscripcion: this.state.codCircunscripcion,
            codDignidad: this.state.codDignidad,
          );

      final newState = this.state.updateResultResponse(resultResponse);

      yield newState;
    } catch (e) {
      print(e);
      yield this.state.emptyResultResponseError();
    }
  }
}
