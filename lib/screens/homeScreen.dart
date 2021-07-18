import 'package:bagberg_shop/providers/auth_provider.dart';
import 'package:bagberg_shop/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  static const String id ='home-screen';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            auth.error='';
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>WelcomeScreen(),
              ));
            } );
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
