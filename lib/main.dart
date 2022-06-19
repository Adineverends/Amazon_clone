import 'package:amazon_clone/authentication/login.dart';
import 'package:amazon_clone/authentication/signup.dart';
import 'package:amazon_clone/responsivness/mobile.dart';
import 'package:amazon_clone/responsivness/responsive_layout.dart';
import 'package:amazon_clone/responsivness/web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCjQHMv8BwTg0NkoID2vRnAXwYxeZekmUs",
      appId: "1:1007094358136:web:2f6ed8fa1ad94a0dbbcd8d",
      messagingSenderId: "1007094358136",
      projectId: "clone-2968a",
      storageBucket: "clone-2968a.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }


  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    title: 'Amazon_clone',
    home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(mobile: mobile(),web: web(),);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            return const login_screen();
          },
        )


  ));
}


  