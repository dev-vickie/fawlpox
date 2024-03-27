import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("information "),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: const Text("Image"),
            subtitle: const Text("Date"),
            leading: const Icon(Icons.image),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          );
        },
      ),
    );
  }
}
