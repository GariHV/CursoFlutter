import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    if(!authProvider.isAuth) Navigator.pushReplacementNamed(context, "/");
    return Scaffold(
      appBar: AppBar(title: Text("Que test quieres hacer?")),
      body: Expanded(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: ()=>{
                  Navigator.pushNamed(context, "/directtest")
                },
                child: Text("Test Directo")
              ),
              ElevatedButton(
                onPressed: ()=>{
                  Navigator.pushNamed(context, "/indirecttest")
                },
                child: Text("Test Inidrecto")
              ),
              ElevatedButton(
                onPressed: ()=>{
                  Navigator.pushNamed(context, "/testacumulador")
                },
                child: Text("Test Acumulador")
              )
            ]
            ),
        )
         ),
      floatingActionButton:
       ElevatedButton(child: Icon(Icons.history), onPressed: (){
        Navigator.pushNamed(context, "/history");
      }),
    );

  }
}