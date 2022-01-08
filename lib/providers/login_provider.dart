import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{

  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  
  String user  = '';
  String password  = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading (bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isformValid(){
    return loginKey.currentState?.validate() ?? false;
  }

}