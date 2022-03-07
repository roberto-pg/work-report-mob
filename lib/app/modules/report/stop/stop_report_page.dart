import 'package:flutter/material.dart';

class StopReportPage extends StatefulWidget {

  const StopReportPage({ Key? key }) : super(key: key);

  @override
  _StopReportPageState createState() => _StopReportPageState();
}

class _StopReportPageState extends State<StopReportPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Stop'),),
           body: Container(),
       );
  }
}