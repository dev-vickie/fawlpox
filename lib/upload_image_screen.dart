import 'dart:io';

import 'package:fawlpox/unhealthy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import file picker
import 'package:file_picker/file_picker.dart';

class UploadImage extends ConsumerStatefulWidget {
  const UploadImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImage> {
  //file
  File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            _file == null
                ? const Text("No Image Selected")
                : Image.file(
                    _file!,
                    height: 300,
                    width: 300,
                  ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final scaff = ScaffoldMessenger.of(context);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false,
                );

                if (result != null) {
                  setState(() {
                    _file = File(result.files.single.path!);
                  });
                  print(_file);
                } else {
                  // User canceled the picker -show snackbar
                  scaff.showSnackBar(
                    const SnackBar(
                      content: Text("No Image Selected"),
                    ),
                  );
                }
              },
              child: Text(_file == null ? "Select Image" : "Change Image"),
            ),
            const SizedBox(
              height: 20,
            ),

            _file == null
                ? const Offstage()
                : ElevatedButton(
                    onPressed: () {
                      if (_file != null) {
                        //show a loading dialog for 3 seconds then navigate to unhealty page
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Loading..."),
                            content: SizedBox(
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) =>  Unhealthy(file: _file!,),
                          ));
                        });
                      } else {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No Image Selected"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Upload Image"),
                  ),
          ],
        ),
      ),
    );
  }
}
