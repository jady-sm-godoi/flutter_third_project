import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_shop/data/store.dart';
import 'package:udemy_shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expireDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final _isValidTime = _expireDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && _isValidTime;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _authentication(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyBhxQ9FpgYpomTU1TzrzfIrJ8j9o0skOmc';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw authException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expireDate': _expireDate!.toIso8601String(),
      });

      _autoLogoutTimer();
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    final expiredDate = DateTime.parse(userData['expireDate']);
    if (expiredDate.isAfter(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expireDate = expiredDate;

    _autoLogoutTimer();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expireDate = null;

    _clearLogoutTimer();
    Store.remove('userData').then((_) => notifyListeners());
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogoutTimer() {
    _clearLogoutTimer();
    final timeToLogout = _expireDate?.difference(DateTime.now()).inSeconds;
    // print(timeToLogout);
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
