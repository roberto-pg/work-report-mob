import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  await dotenv.load();

  Modular.to.addListener(() {
    log(Modular.to.path);
  });

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    log('Error in fetching the cameras: $e');
  }

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
