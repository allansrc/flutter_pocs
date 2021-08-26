import 'package:flutter/material.dart';
import 'package:fractale/sierpinski_carpet.dart';

import 'branching_tree.dart';
import 'dragon_curve.dart';
import 'koch_snowflake.dart';

void main() => runApp(Flutteractals());

class Flutteractals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutteractals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fractale'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size(300, 300),
              painter: BranchingTree(),
              // painter: SierpinskiCarpet(),
              // painter: KochSnowflake(),
              // painter: DragonCurve(),
            ),
          ],
        ),
      ),
    );
  }
}
