import 'dart:math';
import 'package:flutter/material.dart';
import 'dice_roller_page.dart';

class LifeTrackerPage extends StatefulWidget {
  const LifeTrackerPage({super.key});
  @override
  State<LifeTrackerPage> createState() => _LifeTrackerPageState();
}

class _LifeTrackerPageState extends State<LifeTrackerPage> {
  int _playerCount = 2;
  late List<int> _life;
  int? _winnerIndex;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    _resetLife();
  }

  void _resetLife() {
    _winnerIndex = null;
    final start = (_playerCount == 2 ? 20 : 40);
    _life = List.filled(_playerCount, start);
  }

  void _switchMode() => setState(() {
    _playerCount = (_playerCount == 2 ? 4 : 2);
    _resetLife();
  });

  void _highRoll() => setState(() {
    final rolls = List.generate(_playerCount, (_) => _rnd.nextInt(20) + 1);
    _winnerIndex = rolls.indexOf(rolls.reduce(max));
  });

  Widget _navPill({
    required String label,
    required Color color,
    Widget? icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: StadiumBorder(
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        icon: icon ?? const SizedBox.shrink(),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        onPressed: onTap,
      ),
    );
  }

  Widget _lifeBox(int idx, Color bg) {
    final isWinner = idx == _winnerIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _winnerIndex = null),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: Colors.white, width: 4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, size: 32, color: Colors.white),
                    onPressed: () => setState(() => _life[idx]++),
                  ),
                  Text(
                    '${_life[idx]}',
                    style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon:
                    const Icon(Icons.remove, size: 32, color: Colors.white),
                    onPressed: () => setState(() => _life[idx]--),
                  ),
                ],
              ),
            ),
            if (isWinner)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Winner!',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 2-player nav
    final navColumn2 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _navPill(label: 'High Roll', color: Colors.green, onTap: _highRoll),
        _navPill(
          label: 'Back to Home',
          color: Colors.orangeAccent,
          onTap: () => Navigator.pop(context),
        ),
        _navPill(
          label: 'Dice Roller',
          color: Colors.blue,
          icon: Image.asset('assets/d20.png', width: 24, height: 24),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DiceRollerPage()),
          ),
        ),
        _navPill(
          label:
          _playerCount == 2 ? 'Switch to 4 player' : 'Switch to 2 player',
          color: Colors.purple,
          onTap: _switchMode,
        ),
      ],
    );

    // 4-player nav
    final navRow4 = Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        _navPill(label: 'High Roll', color: Colors.green, onTap: _highRoll),
        _navPill(
          label: 'Back to Home',
          color: Colors.orangeAccent,
          onTap: () => Navigator.pop(context),
        ),
        _navPill(
          label: 'Dice Roller',
          color: Colors.blue,
          icon: Image.asset('assets/d20.png', width: 24, height: 24),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DiceRollerPage()),
          ),
        ),
        _navPill(label: 'Switch to 2 player', color: Colors.purple, onTap: _switchMode),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Life Tracker',
              style: TextStyle(
                  fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: _playerCount == 2
                  ? Row(
                children: [
                  Flexible(flex: 1, child: navColumn2),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        _lifeBox(0, Colors.blue),
                        _lifeBox(1, Colors.redAccent),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  // Top row of two life boxes (fills half height)
                  Expanded(
                    child: Row(
                      children: [
                        _lifeBox(0, Colors.blue),
                        _lifeBox(1, Colors.blue),
                      ],
                    ),
                  ),
                  // Nav pills in middle
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: navRow4),
                  // Bottom row of two life boxes (fills half height)
                  Expanded(
                    child: Row(
                      children: [
                        _lifeBox(2, Colors.redAccent),
                        _lifeBox(3, Colors.redAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
