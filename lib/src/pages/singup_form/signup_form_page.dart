
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_repository.dart';
import '../../logic/authentication/authentication_bloc.dart';
import '../../logic/signup_form/signup_form_bloc.dart';
import '../../logic/user/user_bloc.dart';

class SignupFormPage extends StatefulWidget {
  @override
  _SignupFormPageState createState() => _SignupFormPageState();
}

class _SignupFormPageState extends State<SignupFormPage> {
  GlobalKey<FormState> _formKey; 

  final String _errorMessage = 'This field is required';

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
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Signup',
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
        body: SafeArea(
          child: BlocProvider(
            create: (_) => UserBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              authenticationRepository: UserRepositoryImpl()
            ),
            child: BlocProvider(
              create: (context) => SignupFormBloc(
                userBloc: BlocProvider.of<UserBloc>(context)
              ),
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) async {
                  if ( state is UserLoading ) {
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
                                  child: Text("Signing up, Please stand by...")
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if ( state is UserError ) {
                    Navigator.of(context).pop();
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('An error occurred'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              ...state.error.message.keys.map(
                                (key) => ListTile(
                                  title: Text(key + ': ' + state.error.message[key]),
                                )
                              ).toList()
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Approve'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    );
                  } else if ( state is UserLoaded ) {
                    Navigator.pushReplacementNamed(context, 'home');
                  }
                },
                child: BlocBuilder<SignupFormBloc, SignupFormState>(
                  builder: (context, state) {
                    if ( state is SignupFormInitial ) {
                      
                      return SingleChildScrollView(
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          // margin: EdgeInsets.only(
                          //   top: 100
                          // ),
                          // padding: EdgeInsets.symmetric(
                          //   vertical: 20
                          // ),
                          // color: Colors.white,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 200,
                                ),
                                // email
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isEmailValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
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

                                // username
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isUsernameValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        UsernameChanged(value)
                                      );
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.alternate_email_sharp),
                                      hintText: '@username, EX: @john_smith'
                                    ),
                                  ),
                                ),

                                // FullName
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isFullNameValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        FullNameChanged(value)
                                      );
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Your full name, EX: John smith'
                                    ),
                                  ),
                                ),

                                // invite code
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isInviteCodeValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        InviteCodeChanged(value)
                                      );
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.confirmation_num),
                                      hintText: 'Invite Code, EX: 123456'
                                    ),
                                  ),
                                ),

                                // password
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isPasswordValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
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

                                // re-password
                                ListTile(
                                  title: TextFormField(
                                    validator: (value) => !state.isRePasswordValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        RePasswordChanged(value)
                                      );
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Re Password, EX: ********',
                                    ),
                                    obscureText: true
                                  ),
                                ),

                                // language
                                ListTile(
                                  title: DropdownButtonFormField(
                                    validator: (value) => !state.isLanguageValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    value: state.language,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.language),
                                      hintText: 'Language'
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'en',
                                        child: Text('English'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'aa',
                                        child: Text('Qafar'),
                                      )
                                    ], 
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        LanguageChanged(value)
                                      );
                                    }
                                  ),
                                ),

                                // timezone
                                ListTile(
                                  title: DropdownButtonFormField(
                                    validator: (value) => !state.isTimezoneValid ? _errorMessage : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    value: state.timezone,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.timer),
                                      hintText: 'Timezone'
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'US/Pacific',
                                        child: Text('(UTC-8) Pacific Time (US & Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'US/Mountain',
                                        child: Text('(UTC-7) Mountain Time (US & Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'US/Central',
                                        child: Text('(UTC-6) Central Time (US & Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'US/Eastern',
                                        child: Text('(UTC-5) Eastern Time (US & Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'America/Halifax',
                                        child: Text('(UTC-4)  Atlantic Time (Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'America/Anchorage',
                                        child: Text('(UTC-9)  Alaska (US & Canada)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Pacific/Honolulu',
                                        child: Text('(UTC-10) Hawaii (US)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Pacific/Samoa',
                                        child: Text('(UTC-11) Midway Island, Samoa'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Etc/GMT-12',
                                        child: Text('(UTC-12) Eniwetok, Kwajalein'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Canada/Newfoundland',
                                        child: Text('(UTC-3:30) Canada/Newfoundland'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'America/Buenos_Aires',
                                        child: Text('(UTC-3) Brasilia, Buenos Aires, Georgetown'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Atlantic/South_Georgia',
                                        child: Text('(UTC-2) Mid-Atlantic'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Europe/London',
                                        child: Text('Greenwich Mean Time (Lisbon, London)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Europe/Berlin',
                                        child: Text('(UTC+1) Amsterdam, Berlin, Paris, Rome, Madrid'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Europe/Athens',
                                        child: Text('(UTC+2) Athens, Helsinki, Istanbul, Cairo, E. Europe'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Europe/Moscow',
                                        child: Text('(UTC+3) Baghdad, Kuwait, Nairobi, Moscow,Palastine'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Iran',
                                        child: Text('(UTC+3:30) Tehran'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Dubai',
                                        child: Text('(UTC+4) Abu Dhabi, Kazan, Muscat'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Kabul',
                                        child: Text('(UTC+4) Abu Dhabi, Kazan, Muscat'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Yekaterinburg',
                                        child: Text('(UTC+5) Islamabad, Karachi, Tashkent'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Calcutta',
                                        child: Text('(UTC+5:30) Bombay, Calcutta, New Delhi'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Katmandu',
                                        child: Text('(UTC+5:45) Nepal'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Omsk',
                                        child: Text('(UTC+6) Almaty, Dhaka'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Indian/Cocos',
                                        child: Text('(UTC+6:30) Cocos Islands, Yangon'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Krasnoyarsk',
                                        child: Text('(UTC+7) Bangkok, Jakarta, Hanoi'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Krasnoyarsk',
                                        child: Text('(UTC+7) Bangkok, Jakarta, Hanoi'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Hong_Kong',
                                        child: Text('(UTC+8) Beijing, Hong Kong, Singapore, Taipei'),
                                      ),
                                      DropdownMenuItem(
                                        value: '(UTC+8) Beijing, Hong Kong, Singapore, Taipei',
                                        child: Text('(UTC+8) Beijing, Hong Kong, Singapore, Taipei'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Australia/Adelaide',
                                        child: Text('(UTC+9:30) Adelaide, Darwin'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Australia/Sydney',
                                        child: Text('(UTC+10) Brisbane, Melbourne, Sydney, Guam'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Asia/Magadan',
                                        child: Text('(UTC+11) Magadan, Solomon Is., New Caledonia'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Pacific/Auckland',
                                        child: Text('(UTC+11) Magadan, Solomon Is., New Caledonia'),
                                      ),
                                      
                                    ], 
                                    onChanged: (value) {
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        TimezoneChanged(value)
                                      );
                                    }
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
                                      BlocProvider.of<SignupFormBloc>(context).add(
                                        SubmitSignupForm()
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Signup',
                                    style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 18,
                                      color: Theme.of(context).colorScheme.onPrimary
                                    ),
                                  )
                                ),
                              ),
                              

                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}