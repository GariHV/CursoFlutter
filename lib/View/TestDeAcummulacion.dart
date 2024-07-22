
import 'package:aplicacionfinal/Controller/AccTestProvider.dart';
import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestAcumulador extends StatefulWidget{
  @override
  _TestAcumulador createState() => _TestAcumulador();
}

class _TestAcumulador extends State<TestAcumulador>{
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
      final accTestProvider = Provider.of<AccTestProvider>(context);
      final authProvider = Provider.of<AuthProvider>(context);

      return Scaffold(
        appBar: AppBar(title: Text("Test Accumulador")),
        body: Expanded(
          child: Center(
            child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
          children:[
           Visibility( 
              visible: !startTest,
            child:ElevatedButton(
              onPressed:(){
                  accTestProvider.startTest();
                  _showNumber();
                  _startTest();
            },
            child: Text("Empezar"),
            )
           ),
            StreamBuilder(
              stream: accTestProvider.secuenciaController,
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
                        final secueciaValida = accTestProvider.verificarSecuencia(secuenciaController.text,authProvider.email);
                        if(!secueciaValida){
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                        secuenciaController.clear();
                        _showNumber();
                      },
                      child: Text("Verificar")
                    ),
                    ],
                  )
                )
          ]
        )
              )
          )
        );
    }
}