import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {

  @override
  List<Object> get props {
    return [];
  }
}

class AuthenticationInitState extends AuthenticationState{}
class AuthenticationSuccess extends AuthenticationState{
  final User user;

  AuthenticationSuccess(this.user);

  @override
  List<Object> get props {
    return [user];
  }
}
class AuthenticationFailureState extends AuthenticationState{}