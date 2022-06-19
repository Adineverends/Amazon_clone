import 'package:amazon_clone/screen/home.dart';

import 'package:flutter/material.dart';

import '../sell_product/sell_item.dart';

class mobile extends StatefulWidget {
  const mobile({Key? key}) : super(key: key);

  @override
  State<mobile> createState() => _mobileState();
}

class _mobileState extends State<mobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
     theme: ThemeData.dark(),
     
    );
  }
}
