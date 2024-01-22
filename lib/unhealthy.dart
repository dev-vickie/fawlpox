import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Unhealthy extends ConsumerStatefulWidget {
  final File file;
  const Unhealthy({super.key,required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnhealthyState();
}

class _UnhealthyState extends ConsumerState<Unhealthy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: Add items here
            Image.file(
              widget.file,
              height: 300,
              width: 300,
            ),

            const Text("Unhealthy"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
            
          ],
        ),
      ),
    );
  }
}
