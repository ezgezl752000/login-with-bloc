import 'package:bhsoft/bloc/bloc_events.dart';
import 'package:bhsoft/bloc/bloc_state.dart';
import 'package:bhsoft/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';

class Home extends StatefulWidget {
  final UserRepository _userRepository;
  const Home({Key? key,required UserRepository userRepository}) : assert(userRepository!=null),_userRepository = userRepository, super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _usernameController = TextEditingController();
  late final TextEditingController  _passwordController = TextEditingController();
  late LoginBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    // TODO: implement initState

    _bloc = LoginBloc(userRepository: _userRepository);
    super.initState();
  }

  bool get isPopulated =>
      _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        bloc: _bloc,
        builder: (context, state){
          if( state.isSuccess){
            return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ));
          }
          return Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'username'),
                    validator: (_){
                      print('email');
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'password'),
                    validator: (_){
                      print('password');
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  ElevatedButton(onPressed: (){
                    print('$_usernameController.text $_passwordController.text');
                              if(_formKey.currentState!.validate()){
                                _bloc.add(
                                  LoginWithCredentialsPress(
                                    email: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }

                            }, child: Text('Login'),

                    ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
