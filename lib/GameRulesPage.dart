import 'package:flutter/material.dart';


class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Game Rules')),
    body: const Center(child: Text('📖 Official MTG rules')),
  );
}
