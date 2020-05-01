import 'package:flutter/material.dart';
import 'package:using_listview/feederlist/feeder_list.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  GlobalKey<FormState> _key = GlobalKey();

  RegExp emailRegExp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  String _username;
  String _password;

  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLogin ? FeederList() : loginForm(),
//      body: loginForm(),
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 30.0),
          width: 300.0, //size.width * .6,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Insert username";
                    }
                    return null;
                  },
                  maxLength: 50,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    labelText: 'Username',
                    counterText: '',
                    icon: Icon(Icons.account_box,
                        size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _username = text,
                ),
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Insert password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _password = text,
                ),
                IconButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();

                      setState(() {
                        _isLogin = true;
                      });
//                      Navigator.of(context).push(HomeScreen.route(mensaje));
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
