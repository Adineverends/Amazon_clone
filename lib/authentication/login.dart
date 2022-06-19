import 'package:amazon_clone/authentication/signup.dart';
import 'package:amazon_clone/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authmethods.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passcontroller = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginuser(
        email: _emailcontroller.text, password: _passcontroller.text);

    if (res == 'success') {
      //this method will not use bcz to remained in homescreen we have to use percistence method
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print(res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SizedBox(
              height: 64,
            ),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _passcontroller,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => signup()));
                    });
                  },
                  child: Container(
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }

  
}

