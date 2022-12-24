import 'dart:math';

import 'package:flutter/material.dart';
import 'package:future_loading_overlay/future_loading_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _number;

  Future<int> _getNumberFuture() async {
    // Deley the future by 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    return Future.value(Random().nextInt(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Press a button below to run a future'),
            if (_number != null) Text('Future completed with number $_number'),
            ElevatedButton(
              onPressed: () async {
                final result = await showFutureLoadingOverlay<int>(
                  context: context,
                  future: _getNumberFuture(),
                  expanded: false,
                );

                if (mounted) {
                  setState(() {
                    _number = result;
                  });
                }
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
