part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class EnterCalculationsEvent extends HomeEvent {
  final String char;

  const EnterCalculationsEvent(this.char);

  @override
  List<Object?> get props => [char];
}

final class ChangeKeyboardEvent extends HomeEvent {
  final int index;

  const ChangeKeyboardEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

final class NavigateEvent extends HomeEvent {
  final String routeName;
  final Object? arguments;

  const NavigateEvent({required this.routeName, this.arguments});

  @override
  List<Object?> get props => [routeName, arguments];
}

final class CallbackResultEvent extends HomeEvent {
  final String result;

  const CallbackResultEvent(this.result);

  @override
  List<Object?> get props => [result];
}

final class CursorMoveEvent extends HomeEvent {
  const CursorMoveEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeRadianEvent extends HomeEvent {
  final bool isRadian;

  const ChangeRadianEvent({required this.isRadian});

  @override
  List<Object?> get props => [isRadian];
}

final class OpenGmailEvent extends HomeEvent {
  const OpenGmailEvent();

  @override
  List<Object?> get props => [];
}

final class ShareEvent extends HomeEvent {
  const ShareEvent();

  @override
  List<Object?> get props => [];
}

final class InitialEvent extends HomeEvent {
  final String input;

  const InitialEvent({required this.input});

  @override
  List<Object?> get props => [input];
}

final class OnPanStartEvent extends HomeEvent {
  final DragStartDetails details;

  const OnPanStartEvent({required this.details});

  @override
  List<Object?> get props => [details];
}

final class OnPanUpdateEvent extends HomeEvent {
  final DragUpdateDetails details;

  const OnPanUpdateEvent({required this.details});

  @override
  List<Object?> get props => [details];
}


final class OnPanEndEvent extends HomeEvent {
  final DragEndDetails details;

  const OnPanEndEvent({required this.details});

  @override
  List<Object?> get props => [details];
}

final class EmitListOffsetsEvent extends HomeEvent {
  const EmitListOffsetsEvent();

  @override
  List<Object?> get props => [];
}

final class OpenCameraEvent extends HomeEvent {
  const OpenCameraEvent();

  @override
  List<Object?> get props => [];
}
