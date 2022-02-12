import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            TextButton(
              onPressed: () {
                context.pushRoute(const NoteDetailsRoute());
              },
              child: const Text('Go to details screen'),
            ),
            TextButton(
              onPressed: () {
                context.pushRoute(const SearchRoute());
              },
              child: const Text('Go to search screen'),
            ),
          ],
        ),
      ),
    );
  }
}
