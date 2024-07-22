import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool _isAuth = false;
  String _email = "";


  bool get isAuth => _isAuth;
  String get email => _email;


  Future<bool> signin(String email , String pasword)async{
    try{
    final credential  = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: pasword
                  );
      if(credential.user != null ){
        _isAuth = true;
        _email= email;
      }
      notifyListeners();
    }
    catch(e){
      print(e);
      notifyListeners();
    }
    return _isAuth;
  }

  void signOut()async{
    _isAuth = false;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }


}