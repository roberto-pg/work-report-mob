import 'package:flutter/material.dart';

class StartReportPage extends StatefulWidget {

  const StartReportPage({ Key? key }) : super(key: key);

  @override
  _StartReportPageState createState() => _StartReportPageState();
}

class _StartReportPageState extends State<StartReportPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Start'),),
           body: Container(),
       );
  }
}