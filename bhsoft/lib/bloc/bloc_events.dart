import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvents{
  final String email;

  LoginEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvents{
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsPress extends LoginEvents{
  final String email;

  final String password;


  LoginWithCredentialsPress({required this.email,required this.password});

  @override
  List<Object> get props => [password];
}