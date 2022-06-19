import 'package:amazon_clone/responsivness/mobile.dart';
import 'package:amazon_clone/responsivness/web.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobile;
  final Widget web;
   ResponsiveLayout({Key? key,required this.mobile,required this.web}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobile();
      } else {
        return web();
      }
    }));
  }
}
