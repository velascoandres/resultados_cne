part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {}

class OnShowLoading extends LoadingEvent {}

class OnHideLoading extends LoadingEvent {}
