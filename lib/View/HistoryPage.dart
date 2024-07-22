import 'package:aplicacionfinal/Controller/AccTestProvider.dart';
import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:aplicacionfinal/Controller/DirectTestProvider.dart';
import 'package:aplicacionfinal/Controller/IndrectTestProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget{



  @override
  Widget build(BuildContext context){
    final authProbider = Provider.of<AuthProvider>(context);


  return FutureBuilder(
    initialData: [0,0,0],
    future:  Future.wait([
      Provider.of<DirectTestProvider>(context, listen: false).getInfoTest(authProbider.email),
      Provider.of<IndirectTestProvider>(context, listen: false).getInfoTest(authProbider.email),
      Provider.of<AccTestProvider>(context, listen: false).getInfoTest(authProbider.email)
    ]),
    builder:(context,snapshot){
    final data = snapshot.data as List;
    return Scaffold(
      appBar: AppBar(title: Text("Historial")),
      body: Center(
        child: Column(
              children: [
                Text("Test Directo: ${data[0]}"),
                Text("Test Indirecto: ${data[1]}"),
                Text("Test Acumulador: ${data[2]}"),
              ],
            ),
       )
      );
    }
    );
  }
}