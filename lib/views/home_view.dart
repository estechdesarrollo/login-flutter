
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login/services/auth.services.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context)  {

    final authService = Provider.of<AuthService>(context, listen: false); 
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Home',style: TextStyle(fontSize: 30))
          
          ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Text('Bienvenido', style: TextStyle(color: Colors.blueAccent, fontSize: 30),),
            ),
            SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
                color: Colors.blueAccent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  child: Text( 'Salir',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    
                ),
                onPressed: (){
                  authService.logout();
                  Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
                
          ],
        ),

      ),

    );
  }
}