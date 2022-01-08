import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){

            if (!snapshot.hasData) 
              return Text('espere');
            
            
            // ignore: unrelated_type_equality_checks
            if ( snapshot.data == '') {
            Future.microtask((){
              Navigator.of(context).pushReplacementNamed('login');
                
            });
            }else{
            Future.microtask((){
              Navigator.of(context).pushReplacementNamed('home');
            });
            }

            

            return Container();
          },
        ),
      ),
    );
  }
}