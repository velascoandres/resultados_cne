part of 'loading_bloc.dart';

@immutable
class LoadingState {
  final bool isLoading;

  LoadingState({this.isLoading = true});

  LoadingState copyWith({bool isLoading}) =>
      LoadingState(isLoading: isLoading ?? this.isLoading);
}
