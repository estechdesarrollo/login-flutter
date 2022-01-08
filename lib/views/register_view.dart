import 'package:flutter/material.dart';
import 'package:login/providers/login_provider.dart';
import 'package:login/services/auth.services.dart';
import 'package:login/services/services.dart';
import 'package:provider/provider.dart';
import 'package:login/iu/input_decorations.dart';
import 'package:login/widgets/background.dart';
import 'package:login/widgets/card_container.dart';

class RegisterView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Crear cuenta', style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
                    SizedBox( height: 30),

                    ChangeNotifierProvider(
                      create: (BuildContext context) => LoginProvider(),
                      child: _LoginForm(),
                    ),
                    
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'), 
                child: Text('Ingresar con tu cuenta', style: TextStyle(fontSize: 20, color: Colors.white)),
                
              ),              
              SizedBox(height: 30),
            ],
          ),
          )
      )
    );
  }
}

//formulario
class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final loginForm = Provider.of<LoginProvider>(context);

    return Container(
      child: Form(
        key: loginForm.loginKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.loginInputDecoration(
                hintText: 'JuanE8',
                labelText: 'Usuario',
                prefixIcon: Icons.person,
              ),
              onChanged: (value) => loginForm.user = value,
              validator: (value) {
                return (value.isEmpty) 
                ?  'El usuario no puede estar vacio'
                :  null;
              }
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.loginInputDecoration(
                hintText: '****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value){
                return (value != null && value.length>=4)
                ? null
                : 'La contraseña debe tener minimo 4 digitos';
              },
            ) ,
            SizedBox(height: 30),
            
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueAccent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espere'
                  : 'Registrar',
                   style: TextStyle(color: Colors.white, fontSize: 20)
                  ),
              ),
              onPressed: loginForm.isLoading ? null :() async{
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if (!loginForm.isformValid()) return;

                loginForm.isLoading = true;

                //validar si el registro es correcto
                final String errorMessage = await authService.regUser(loginForm.user, loginForm.password);
                
                if (errorMessage == null) {
                  Navigator.pushReplacementNamed(context, 'login');
                  
                } else {
                  // print(errorMessage);
                  NotificationsService.showSnackbar(errorMessage);
                loginForm.isLoading = false;
                }
              }
              ),
          ],
        ),
      ),
    );
  }
}

