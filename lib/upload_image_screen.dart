import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ImageClassifier extends StatefulWidget {
  const ImageClassifier({Key? key}) : super(key: key);

  @override
  State createState() => _ImageClassifierState();
}

class _ImageClassifierState extends State<ImageClassifier> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  var results = "";
  // var dataList = [];
  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      print("Hit pre det");
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      print("Hit pre det");
      detectimage(file!);
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future detectimage(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    print("Hit det");
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
      // asynch: false,
    );
    print("Hit post det");
    setState(() {
      _recognitions = recognitions;
      results = recognitions.toString();
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
    });
    print("//////////////////////////////////////////////////");
    print(recognitions);
    // print(dataList);
    print("//////////////////////////////////////////////////");
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Image Classifier",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          (_image != null)
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(
                    File(
                      _image!.path,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text(
                        "No image selected",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: [
                results != ""
                    ? Card(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: results.contains("healthy")
                              ? const Column(
                                  children: [
                                    Text("Healthy"),
                                    //Any other information for healthy goes in this column
                                    Text(
                                      "Preventive Measures Advised",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "The bird appears healthy. However, it's essential to take preventive measures to maintain the health of your flock. Ensure good hygiene practices are followed, regularly sanitize equipment, and maintain clean living conditions. Consider vaccinating the flock against common diseases, and quarantine new flock arrivals to prevent disease transmission."),
                                  ],
                                )
                              : results.contains("unhealthy")
                                  ? const Column(
                                      children: [
                                        Text("Unhealthy"),
                                        //Any other information for unhealthy goes in this column
                                        Text(
                                          "Immediate attention needed",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Based on the image analysis, there are possible signs of fowlpox. The first step is to identify the sick bird, quarantine it, and sample it for diagnosis. Antibiotics may be provided to the flock as a preventive measure. Additionally, ensure hygiene practices are followed, including sanitizing equipment and contacting a veterinary professional for further guidance."),
                                      ],
                                    )
                                  : const Column(
                                      children: [
                                        Text("Not Recognized"),
                                        //Any other information for not recognized goes in this column
                                        Text(
                                          "Image not recognized",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "The image provided could not be recognized. Please ensure the image is clear and the subject is of required input."),
                                      ],
                                    ),
                        ),
                      )
                    : const Offstage(),
              ],
            ),
          ),
        ],
      ), 
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "pickImageFab",
            onPressed: _pickImage,
            tooltip: "Pick Image",
            child: const Icon(Icons.image),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "captureImageFab",
            onPressed: _captureImage,
            tooltip: "Capture Image",
            child: const Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}
