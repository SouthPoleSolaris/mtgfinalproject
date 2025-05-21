import 'package:flutter/material.dart';
import 'dice_roller_page.dart';
import 'LifeTrackerPage.dart';
import 'UpcomingEventsPage.dart';
import 'CardSearchPage.dart';
import 'GameRulesPage.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    // helper to build each pill‐button
    Widget navButton({
      required Color color,
      required Widget icon,
      required String label,
      required VoidCallback onPressed,
    }) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: StadiumBorder(
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
        ),
        icon: icon,
        label: Text(label, style: const TextStyle(fontSize: 18)),
        onPressed: onPressed,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // header logo & title
              Image.asset('assets/d20.png', width: 120, height: 120),
              const SizedBox(height: 16),
              const Text(
                'Delver of\nSecrets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Roll dice
              navButton(
                color: Colors.blue,
                icon: Image.asset('assets/d20.png', width: 28, height: 28),
                label: 'Roll dice',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DiceRollerPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Life tracker with badge "2"
              navButton(
                color: Colors.green,
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                label: 'Life tracker',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LifeTrackerPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Upcoming events
              navButton(
                color: Colors.redAccent,
                icon: const Icon(Icons.calendar_today,
                    color: Colors.white, size: 28),
                label: 'Upcoming events',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UpcomingEventsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Scryfall card search
              navButton(
                color: Colors.orange,
                icon: const Icon(Icons.search,
                    color: Colors.white, size: 28),
                label: 'Scryfall card search',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CardSearchPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Game rules
              navButton(
                color: Colors.grey,
                icon: const Icon(Icons.menu_book,
                    color: Colors.white, size: 28),
                label: 'Game rules',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GameRulesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}







