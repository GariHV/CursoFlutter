
import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:aplicacionfinal/Controller/IndrectTestProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndirectTest extends StatefulWidget{
  @override
  _IndirectTest createState() => _IndirectTest();
}

class _IndirectTest extends State<IndirectTest>{
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
      final indirectTest = Provider.of<IndirectTestProvider>(context);
      final authProvider = Provider.of<AuthProvider>(context);

      return Scaffold(
        appBar: AppBar(title: Text("Test Indirecto")),
        body: Expanded(
          child: Center(
            child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
          children:[
           Visibility( 
              visible: !startTest,
            child:ElevatedButton(
              onPressed:(){
                  indirectTest.startTest();
                  _showNumber();
                  _startTest();
            },
            child: Text("Empezar"),
            )
           ),
            StreamBuilder(
              stream: indirectTest.secuenciaController,
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
                        final secueciaValida = indirectTest.verificarSecuencia(secuenciaController.text,authProvider.email);
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