
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DirectTestProvider extends ChangeNotifier {
  bool _isRuning = false;
  List<int> _secuenciaActual =[];
  StreamController<List<int>> _secuenciaController = StreamController.broadcast();
  List<int> _secuenciaAnterior = [];
  int _puntos = 0;
  int numeros = 2;


  Stream<List<int>> get secuenciaController => _secuenciaController.stream;
  bool get isRuning => _isRuning;
  int get puntos => _puntos;

  Future<String> getInfoTest(String email)async {
    var collection = FirebaseFirestore.instance.collection("test directo");
    var doc = await collection.doc(email).get();
    if(doc.exists){
      return doc.get("test").toString();
    }
    return "0";
  }

  void startTest(){
    _isRuning = true;
    numeros = 2;
    _generarSecuencia();
  }

  void _generarSecuencia(){
    if(_isRuning){
      _secuenciaActual = List.generate(numeros, (index) => Random().nextInt(9) + 1 );
      numeros++;
      _secuenciaController.add(_secuenciaActual);
      _secuenciaAnterior = _secuenciaActual;
      notifyListeners();
    }
  }

  bool verificarSecuencia(String secuenciaUsuario,String email){

    String emailConfirm = email;

    if(emailConfirm == ""){
      emailConfirm = "anonimo";
    }

    if(_isRuning){
      String secuencia = _secuenciaAnterior.join("");
      if(secuencia == secuenciaUsuario){
        _puntos++;
        _generarSecuencia();
        return true;
      }
      else {
        FirebaseFirestore.instance.collection("test directo").doc(emailConfirm).set({"test":_puntos});
        _isRuning = false;
        numeros = 2;
        _puntos = 0;
        return false;
      }
    }
  return false;
  }
}