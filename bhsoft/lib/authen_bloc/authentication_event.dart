import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}