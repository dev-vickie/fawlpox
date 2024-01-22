import 'package:fawlpox/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/repository/auth_repository.dart';
import 'upload_image_screen.dart';

class HomePage extends ConsumerWidget {
  final User? user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  "Fowlpox Detection App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
        
            ListTile(
              title: const Text("History"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const History(),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: const Text("PAGE NAME"),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       //TODO: Add page here
            //       MaterialPageRoute(
            //         builder: (context) => const (),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.green[100],
              image: const DecorationImage(
                image: AssetImage("assets/download.jpeg"),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "This is a Fowlpox Detection App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Fowlpox is a viral disease in chickens caused by the avian poxvirus. It spreads through direct contact or contaminated materials, causing skin lesions or respiratory issues. Though not usually fatal, it can impact egg production and growth. Prevention involves vaccination and controlling the spread through biosecurity measures.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "This app is designed to detect fowlpox in chickens using machine learning and image processing techniques. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens. It is a simple app that can be used by anyone to detect fowlpox in chickens.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Press the button below to start the detection process"),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadImage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Start Detection"),
            ),
          ),
        ],
      ),
    );
  }
}
