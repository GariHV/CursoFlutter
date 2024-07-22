import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title: Text("Inicio sesion")),
      body: FormLogin(),
    );
  }

}

class FormLogin extends StatefulWidget{
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin>{

  TextEditingController emailController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext contex){

    final authProvider = Provider.of<AuthProvider>(context);
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
            ElevatedButton(
              onPressed:  () async{
                String email = emailController.text;
                String pasword = contrasenaController.text;
                bool isAuth = await authProvider.signin(email,pasword);
                if(isAuth){
                  Navigator.pushReplacementNamed(context, "/home");
                }

              },
              child: Text("Login"),
            )
          ],
        )
      )
    );
  }
}