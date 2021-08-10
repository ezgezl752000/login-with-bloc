

import 'package:bhsoft/bloc/bloc_events.dart';
import 'package:bhsoft/bloc/bloc_state.dart';
import 'package:bhsoft/bloc/validators.dart';
import 'package:bhsoft/data/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{
  final UserRepository _userRepository;

  LoginBloc( {required UserRepository userRepository}) : _userRepository = userRepository,super(LoginState.initial());


  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if(event is LoginEmailChanged){
      yield* _mapLoginEmailChangedToState(event.email);
    }else if(event is LoginPasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    }else if(event is LoginWithCredentialsPress){
      yield* _mapLoginWithCredentialsPressedToState(email: event.email, password: event.password);
    }
  }

  Stream<LoginState>  _mapLoginEmailChangedToState(String email) async*{
    yield state.update(isEmailValid: Validators.isValidEmail(email), isPasswordValid: true);
  }
  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidEmail(password), isEmailValid: true,
    );
  }
  Stream<LoginState> _mapLoginWithCredentialsPressedToState({required String email, required String password}) async*{
    yield  LoginState.loading();
    try{
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    }
    catch (_){
      yield LoginState.failure();
    }
  }
}