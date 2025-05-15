import 'package:flutter/material.dart';
import 'dice_roller_page.dart';  

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delver of Secrets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF5C3B3E),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // your existing home‐page layout
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/d20.jpg', width: 100, height: 100),
              const SizedBox(height: 12),
              const Text(
                'Delver of\nSecrets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: const StadiumBorder(),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                icon: Image.asset('assets/images/d20.jpg',
                    width: 24, height: 24),
                label: const Text('Roll dice'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DiceRollerPage()),
                  );
                },
              ),
              const SizedBox(height: 12),

              // …other buttons (life tracker, events, etc.)…
            ],
          ),
        ),
      ),
    );
  }
}

// stub pages so your app still compiles
class LifeTrackerPage extends StatelessWidget {
  const LifeTrackerPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Life Tracker')),
    body: const Center(child: Text('❤️ Track player life totals')),
  );
}

class UpcomingEventsPage extends StatelessWidget {
  const UpcomingEventsPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Upcoming Events')),
    body: const Center(child: Text('📅 Your next game nights')),
  );
}

class CardSearchPage extends StatelessWidget {
  const CardSearchPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Card Search')),
    body: const Center(child: Text('🔍 Search Scryfall API')),
  );
}

class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Game Rules')),
    body: const Center(child: Text('📖 Official MTG rules')),
  );
}
