import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:work_report/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    initializeCamera(selectedCamera);
    super.initState();
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectedCamera = 0;
  List<File> capturedImages = [];
  FlashMode? _currentFlashMode;

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    _currentFlashMode = _controller.value.flashMode;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  capturedImages.isEmpty) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CameraPreview(_controller));
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: capturedImages.isNotEmpty
                        ? DecorationImage(
                            image: FileImage(capturedImages.last),
                            fit: BoxFit.contain)
                        : null,
                  ),
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  if (cameras.length > 1) {
                    setState(() {
                      selectedCamera = selectedCamera == 0 ? 1 : 0;
                      initializeCamera(selectedCamera);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('No secondary camera found'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                icon: const Icon(Icons.cameraswitch, color: Colors.white),
              ),
              IconButton(
                onPressed: () async {
                  await _controller.setFlashMode(
                    FlashMode.off,
                  );
                  setState(() {
                    _currentFlashMode = FlashMode.off;
                  });
                },
                icon: Icon(
                  Icons.flash_off,
                  color: _currentFlashMode == FlashMode.off
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await _initializeControllerFuture;
                  var xFile = await _controller.takePicture();
                  log(xFile.path);
                  setState(() {
                    capturedImages.add(File(xFile.path));
                  });
                },
                icon: const Icon(Icons.camera, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
