import 'package:bagberg_shop/providers/auth_provider.dart';
import 'package:bagberg_shop/screens/map_screen.dart';
import 'package:bagberg_shop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/location_provider.dart';
import 'screens/homeScreen.dart';
import 'screens/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_)=>LocationProvider(),
        ),
      ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>SplashScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        MapScreen.id:(context)=>MapScreen(),
      },
      //themeMode: ThemeMode.system,
    );
  }
}


