import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:login/services/services.dart';
import 'package:provider/provider.dart';


class AuthService extends ChangeNotifier {
  final String _baseUrl = '10.0.2.2:3000';

  final storage = new FlutterSecureStorage();

  // crear usuario
  Future<String> regUser( String user, String password) async {

    final Map<String, dynamic> authData = {
      'user'    : user,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/api/user/register');
   
    final resp = await http.post(url, body: authData);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    
    // print(decodedResp);
    if (decodedResp.containsKey('_id')) {
      return null;
    } else {
       return decodedResp['message'];
    }
  }

  //login
  
  Future<String> login( String user, String password, BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final Map<String, dynamic> authData = {
      'user'    : user,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/api/user/log');
   
    final resp = await http.post(url, body: authData);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    
    // print(decodedResp);
    if (decodedResp.containsKey('tokenReturn')) {
            Future.microtask(() {
              Timer.periodic(Duration(seconds: 5), (Timer timer) async{
                  final _id = decodedResp['user']['_id'];
                  final respuesta = await http.get('http://192.168.1.5:3000/api/user/verify?_id='+ _id);
                  final body = jsonDecode(respuesta.body);
                  final state = body['state'];
                  print(body['state']);

                  if (state == 0) {
                    authService.logout();
                    NotificationsService.showSnackbar('Su usuario ha sido DESACTIVADO');
                    Timer(Duration(seconds: 4), () {
                    SystemNavigator.pop();
                    });
                  } else {
                  }

              });

            });
      storage.write(key: 'token', value: decodedResp['tokenReturn']);// guardar token
    
      return null;
    } else {
       return decodedResp['message'];
    }

  }
  //deslogueo
  Future logout() async {
    return await storage.deleteAll();
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<http.Response> verify(url) {
    return Future.delayed(Duration(seconds: 3),()async{
    var respuesta = await http.get(url);
        return respuesta;
    
    });
    
    
  }


}
