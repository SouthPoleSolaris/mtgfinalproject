import 'package:flutter/material.dart';


class UpcomingEventsPage extends StatelessWidget {
  const UpcomingEventsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Upcoming Events')),
    body: const Center(child: Text('📅 Your next game nights')),
  );
}