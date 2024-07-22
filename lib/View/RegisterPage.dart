import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget{



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title: Text("Registro")),
      body: FormRegister(),
    );
  }

}

class FormRegister extends StatefulWidget{
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister>{

  TextEditingController emailController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController contrasena2Controller = TextEditingController();

  @override
  Widget build(BuildContext contex){
    return Padding(
      padding: EdgeInsets.all(16),
        child:Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),
            TextFormField(
              controller: contrasenaController,
              decoration: InputDecoration(
                labelText: "Contraseña"
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: contrasena2Controller,
              decoration: InputDecoration(
                labelText: "Repita la contraseña"
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed:  () async{
                String email = emailController.text;
                String pasword = contrasenaController.text;
                String pasword2 = contrasena2Controller.text;
                if(pasword == pasword2){
                  final register = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: pasword
                    );
                    print(register);
                }

     
              },
              child: Text("Register"),
            )
          ],
        )
      )
    );
  }
}