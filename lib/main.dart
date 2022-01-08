import 'package:flutter/material.dart';
import 'package:login/services/auth.services.dart';
import 'package:login/services/notifications.service.dart';
import 'package:login/views/views.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products App',
      initialRoute: 'checking',
      routes: {
        'login'   :(_) => LoginView(),
        'register':(_) => RegisterView(),
        'home'    :(_) => HomeView(),
        'checking':(_) => CheckAuthView(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      
    );
    
  }
}