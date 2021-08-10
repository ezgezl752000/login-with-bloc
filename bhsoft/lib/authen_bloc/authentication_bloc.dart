import 'dart:async';
import 'package:bhsoft/authen_bloc/authentication_event.dart';
import 'package:bhsoft/authen_bloc/authentication_state.dart';
import 'package:bhsoft/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository): super(AuthenticationInitState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield AuthenticationSuccess(user!);
      } else {
        yield AuthenticationFailureState();
      }
    } catch (_) {
      yield AuthenticationFailureState();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    User user  = _userRepository.getUser() as User;
    yield AuthenticationSuccess(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationFailureState();
    _userRepository.signOut();
  }
}