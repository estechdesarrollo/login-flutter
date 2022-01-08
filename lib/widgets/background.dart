import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  final Widget child;

  const Background({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _BackgrounColor(),

          _IconHead(),

          this.child,

        ],
      ),
    );
  }
}

//Icono Principal cabecera
class _IconHead extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(Icons.run_circle_outlined, color: Colors.white, size: 100),
      ),
    );
  }
}

//fondo degradado login
class _BackgrounColor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      width:  double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Color.fromRGBO(78,52,222, 1),
          ]
        )
      ),
    );
  }

  

 
}