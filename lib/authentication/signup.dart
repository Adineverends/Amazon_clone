import 'dart:typed_data';

import 'package:amazon_clone/authentication/login.dart';
import 'package:amazon_clone/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'authmethods.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passcontroller = TextEditingController();

  final TextEditingController _usernamecontroller = TextEditingController();

  Uint8List? _image;

  //for signup loading
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();

    _usernamecontroller.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();

    XFile? _file = await _imagepicker.pickImage(source: source);

    if (_file != null) {
      // we are using uint8list bcz it is avalable in web
      return await _file.readAsBytes();
    }

    print('no image selected');
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void selectImage() async {
    final ImagePicker _picker = ImagePicker();
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods().signUpuser(
        email: _emailcontroller.text,
        password: _passcontroller.text,
        username: _usernamecontroller.text,
        file: _image!);

    setState(() {
      isLoading = false;
    });

    if (res != 'sucess') {
      showSnackBar(res, context);
    }
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
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('assetss/user.png'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 44,
            ),
            TextField(
              controller: _usernamecontroller,
              decoration: InputDecoration(hintText: 'Enter your username'),
            ),
            const SizedBox(
              height: 24,
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
              onTap: () async {
                /*   setState(() {
                 AuthMethods().signUpUser(email: _emailcontroller.text, password: _passcontroller.text, username:_usernamecontroller.text, bio: _biocontroller.text);
                });

         
                String res = await AuthMethods().signUpUser(
                    email: _emailcontroller.text,
                    password: _passcontroller.text,
                    username: _usernamecontroller.text,
                    bio: _biocontroller.text,
                    file: _image!);
                print(res); */

                signUpUser();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Home()));
              },
              child: Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Sign up'),
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
                  child: Text("Do you have account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => login_screen()));
                    });
                  },
                  child: Container(
                    child: Text(
                      "Sign in",
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
