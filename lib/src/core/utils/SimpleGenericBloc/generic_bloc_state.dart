part of 'generic_bloc.dart';

abstract class SimpleBlocState {}

class LoadingState extends SimpleBlocState {}

class InitialState extends SimpleBlocState {}

class SuccessState<T> extends SimpleBlocState {
  final T items;
  final bool hasReachedMax;
  SuccessState(this.items, this.hasReachedMax);
}

class ErrorState extends SimpleBlocState {
  final String error;
  ErrorState(this.error);
}
