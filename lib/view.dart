import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopwatch/provider.dart';

class count extends ConsumerStatefulWidget {
  const count({super.key});

  @override
  ConsumerState<count> createState() => _countState();
}

class _countState extends ConsumerState<count> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterProvider);
    // AsyncValue<int> counter1 = ref.watch(counterProvider1);
    return StreamBuilder(
      stream: counter,
      builder: (context, snapshot) {
        int counter = snapshot.data ?? ref.watch(startNumProvider);
        return Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            leading: IconButton(icon:const Icon(Icons.arrow_back),
                      onPressed: () async {
                        
                        ref.read(statusProvider.notifier).state=false;
                        Navigator.pop(context);
                        ref.read(startNumProvider.notifier).state = counter;
                      },
                      ),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
          ),
          body: Column(children: [
            Center(child: Text("counter: $counter", style:  const TextStyle(fontSize: 30),)),
            // Center(child: Text("counter: $counter1", style:  const TextStyle(fontSize: 30),))
            ]),
        );
      }
    );
  }
}