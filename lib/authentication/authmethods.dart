import 'dart:typed_data';

import 'package:amazon_clone/authentication/storagemethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 Future<String> signUpuser({
   required String email,
    required String password,
    required String username,
    
    required Uint8List file,
 }
 
 
 ) async{
   String res = 'Some error ocurred';

   try{
    if(
      email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          
          file != null
    ){
      UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
   

String photourl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

     await _firestore.collection('users').doc(cred.user!.uid).set(
      {
          'username': username,
          'uid': cred.user!.uid,
         // 'password':password,
          'email': email,
          'phtoUrl': photourl,
      }
     );

res='sucess';




   
   
    }
   }

    catch (e) {
      res = e.toString();
    }

    return res;
 }
































  Future<String> loginuser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the field';
      }
    } catch (e) {
      e.toString();
    }

    return res;
  }
}
