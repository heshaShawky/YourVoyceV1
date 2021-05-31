import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_repository.dart';
import '../../logic/authentication/authentication_bloc.dart';
import '../../logic/login_form/login_form_bloc.dart';
import '../../logic/user/user_bloc.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final String errorMessage = 'This field is required';

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ( FocusScope.of(context).hasFocus ) {
          // print('object');
          FocusScope.of(context).unfocus();
        }
          
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Login',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary
          ),
          brightness: Brightness.light,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: BlocProvider(
          create: (context) => UserBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authenticationRepository: UserRepositoryImpl()
          ),
          child: BlocProvider(
            create: (context) => LoginFormBloc(
              userBloc: BlocProvider.of<UserBloc>(context)
            ),
            child: MultiBlocListener(
              listeners: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (contex, state) {
                    // if ( state is AuthenticationAuthenticated ) {
                    //   FocusScope.of(context).unfocus();
                    //   if ( Navigator.canPop(context) ) {
                    //     Navigator.of(context).pop();
                    //     Navigator.of(context).pop();
                    //   }
                    // }
                  },
                ),

                BlocListener<UserBloc, UserState>(
                  listener: (contex, state) async{
                    if ( state is UserError ) {
                      Navigator.of(context).pop();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if ( state.error.message is String ) {
                            return AlertDialog(
                              title: Text('An error occurred'),
                              content: SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(state.error.message)
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                          return AlertDialog(
                            title: Text('An error occurred'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  ...state.error.message.keys.map(
                                    (key) => ListTile(
                                      title: Text(key.toString().toUpperCase() + ': ' + state.error.message[key]),
                                    )
                                  ).toList()
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                        
                      );
                    } else if ( state is UserLoading ) {
                      FocusScope.of(context).unfocus();
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text("Signing In, Please stand by...")
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if ( state is UserLoaded ) {
                      Navigator.pushReplacementNamed(context, 'home');
                    }
                  },
                )
              ],
              child: BlocBuilder<LoginFormBloc, LoginFormState>(
                builder: (context, state) {
                  if ( state is LoginFormInitial ) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 200,
                              ),
                              ListTile(
                                title: TextFormField(
                                  validator: (value) => !state.isEmailValid ? errorMessage : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    BlocProvider.of<LoginFormBloc>(context).add(
                                      EmailChanged(value)
                                    );
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Your Email, EX: myname@example.com'
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  validator: (value) => !state.isPasswordValid ? errorMessage : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    BlocProvider.of<LoginFormBloc>(context).add(
                                      PasswordChanged(value)
                                    );
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: 'Your Password, EX: ********',

                                  ),
                                  obscureText: true
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.only(top: 10),
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    if ( _formKey.currentState.validate() ) {
                                      BlocProvider.of<LoginFormBloc>(context).add(
                                        SubmitLoginForm()
                                      );
                                    }
                                  }, 
                                  child: Text(
                                    'Login',
                                    style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 18,
                                      color: Theme.of(context).colorScheme.onPrimary
                                    ),
                                  )
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    );
                  }

                  
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }, 
              ),
            )
          ),
        ),
        
      ),
    );
  }
}