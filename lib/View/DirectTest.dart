
import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:aplicacionfinal/Controller/DirectTestProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectTest extends StatefulWidget{
  @override
  _DirectTest createState() => _DirectTest();
}

class _DirectTest extends State<DirectTest>{
  TextEditingController secuenciaController = TextEditingController();

  bool showNumber = false;
  bool startTest = false;

  void _showNumber(){
    setState(() {
      showNumber = true;
    });
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        showNumber = false;
      });
    });
  }

  void _startTest(){
    setState(() {
      startTest = true;
    });
  }


 @override
Widget build(BuildContext context){
  final directTest = Provider.of<DirectTestProvider>(context);
  final authProvider = Provider.of<AuthProvider>(context);

  return Scaffold(
    appBar: AppBar(title: Text("Test Directo")),
    body: Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
           Visibility( 
              visible: !startTest,
            child:ElevatedButton(
              onPressed:(){
                  directTest.startTest();
                  _showNumber();
                  _startTest();
            },
            child: Text("Empezar"),
            )
           ),
            StreamBuilder(
              stream: directTest.secuenciaController,
              builder: (context, snapshot){
                  if(snapshot.hasData && showNumber){
                    return Text(snapshot.data!.join(""), style: TextStyle(fontSize: 24),);
                  }
                  return Text("");
              }),
              Visibility(
                visible: !showNumber && startTest,
                child: Column(
                    children: [
                    TextFormField(
                      controller: secuenciaController,
                      decoration: InputDecoration(
                        labelText: "Ingrese la secuencia",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final secueciaValida = directTest.verificarSecuencia(secuenciaController.text,authProvider.email);
                        if(!secueciaValida){
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                        _showNumber();
                        secuenciaController.clear();
                      },
                      child: Text("Verificar")
                    ),
                    ],
                  )
                )
          ]
        )
      )
    ),
  );
}
    }
