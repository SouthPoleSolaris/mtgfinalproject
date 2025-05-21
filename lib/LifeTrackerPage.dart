import 'package:flutter/material.dart';

class LifeTrackerPage extends StatelessWidget {
  const LifeTrackerPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Life Tracker')),
    body: const Center(child: Text('❤️ Track player life totals')),
  );
}