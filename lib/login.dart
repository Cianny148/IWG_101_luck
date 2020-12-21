import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User user;
void main() => runApp(new LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '4SF7kfTsgF2L2VWXH3wYUQbES',
    consumerSecret: '5UdPOW4HFrZ9jI7QhQ1rHHvTplZ0nb84oemiJ1OP6TDxwIGWPZ',
  );

  String _message = 'Logged out.';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences _prefs;
  bool _loggedIn = false;
  bool _loading = true;
  String _token;
  String _secret;
  String _name;
  String _userID;

  void _login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        newMessage = 'Logged in! username: ${result.session.username}';
        _loggedIn = true;
        var session = result.session;
        _name = session.username;
        _userID = session.userId;
        _token = session.token;
        _secret = session.secret;
        print(_token);
        print(_secret);
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        _loggedIn = false;
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
        _loggedIn = false;
        break;
    }

    setState(() {
      _message = newMessage;
    });
  }

  void _logout() async {
    await twitterLogin.logOut();

    setState(() {
      _message = 'Logged out.';
    });
  }

  void _fireLog() async {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Twitter login'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_message),
              new RaisedButton(
                child: new Text('Log in'),
                onPressed: _login,
              ),
              new RaisedButton(
                child: new Text('Log out'),
                onPressed: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
