import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xcffFF8906),
        child: InkWell(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              height: 80,
              width: 80,
            )),
      ),
    );
  }
}
