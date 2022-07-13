/*
 * @file scan.dart
 * @author Sciroccogti (scirocco_gti@yeah.net)
 * @brief 
 * @date 2022-07-12 11:36:34
 * @modified: 2022-07-12 11:45:05
 */

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_process;
import 'package:raptorq_in_jabcode/jabcode/generated_jabcode.dart';

import '../var.dart';
import '../jabcode/import_jabcode.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;

  @override
  void initState() {
    super.initState();

    // TODO 修改分辨率
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _initControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            if (kDebugMode) {
              print('User denied camera access.');
            }
            break;
          default:
            if (kDebugMode) {
              print('Handle other errors.');
            }
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan"),
        // toolbarHeight: 47,
      ),
      body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<void>(
            future: _initControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            image_process.Image srcImage =
                image_process.decodeJpg(File(image.path).readAsBytesSync()) ??
                    image_process.Image(0, 0);
            image_process.Image dstImage = image_process.copyCrop(
                srcImage,
                0,
                srcImage.height ~/ 2 - srcImage.width ~/ 2,
                srcImage.width,
                srcImage.width);
            dstImage = image_process.copyResize(dstImage, width: 1080);
            File("/data/user/0/edu.seu.raptorq_in_jabcode/cache/out.png")
                .writeAsBytesSync(image_process.encodePng(dstImage));

            if (!mounted) return;

             String decodedString = scanImage(
                "/data/user/0/edu.seu.raptorq_in_jabcode/cache/out.png");

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath:
                      "/data/user/0/edu.seu.raptorq_in_jabcode/cache/out.png",
                  decodedString: decodedString,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            if (kDebugMode) {
              print(e);
            }
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String decodedString;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.decodedString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [Image.file(File(imagePath)), Text(decodedString)],
      ),
    );
  }
}

String scanImage(String imagePath) {
  Pointer<Char> jabString = imagePath.toNativeUtf8().cast<Char>();
  Pointer<jab_bitmap> bitmap = jabCode.readImage(jabString);
  Pointer<Int> decodeStatus = malloc.allocate(sizeOf<Int>());
  Pointer<jab_decoded_symbol> symbols =
      malloc.allocate(MAX_SYMBOL_NUMBER * sizeOf<jab_decoded_symbol>());
  Pointer<jab_data> decodedData = jabCode.decodeJABCodeEx(
      bitmap, NORMAL_DECODE, decodeStatus, symbols, MAX_SYMBOL_NUMBER);
  // Pointer<Pointer<Uint8>> retData = decodedData.cast<Pointer<Uint8>>().elementAt(1);
  int len = decodedData.ref.length;
  String retStr =
      jabCode.jab_data2char(decodedData).cast<Utf8>().toDartString(length: len);
  // String str = retData.value.cast<Utf8>().toDartString(length: decodedData.ref.length);
  malloc.free(decodeStatus);
  return retStr;
}
