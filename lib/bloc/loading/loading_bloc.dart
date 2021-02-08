import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingState());

  @override
  Stream<LoadingState> mapEventToState(
    LoadingEvent event,
  ) async* {
    if (event is OnHideLoading) {
      yield this.state.copyWith(isLoading: false);
    } else if (event is OnShowLoading){
      yield this.state.copyWith(isLoading: true);
    }
  }
}
