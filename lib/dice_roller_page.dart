import 'dart:math';

import 'package:flutter/material.dart';

class DiceRollerPage extends StatefulWidget {
  const DiceRollerPage({super.key});
  @override
  State<DiceRollerPage> createState() => _DiceRollerPageState();
}

class _DiceRollerPageState extends State<DiceRollerPage> {
  final _rnd = Random();
  final _customController = TextEditingController();

  void _showResult(String label, String result) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label → $result')),
    );
  }

  void _rollCoin() {
    final side = _rnd.nextBool() ? 'Heads' : 'Tails';
    _showResult('Coin', side);
  }

  void _rollStandard(int faces) {
    final roll = _rnd.nextInt(faces) + 1;
    _showResult('d$faces', roll.toString());
  }

  void _rollCustom() {
    final n = int.tryParse(_customController.text) ?? 0;
    if (n < 1) {
      _showResult('Custom', 'Invalid # of faces');
    } else {
      final roll = _rnd.nextInt(n) + 1;
      _showResult('d$n', roll.toString());
    }
  }

  Widget _dieColumn({
    required String label,
    required Widget icon,
    VoidCallback? onRoll,
  }) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // grey pill label
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),

          // icon
          icon,
          const SizedBox(height: 12),

          // roll button
          if (onRoll != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: const StadiumBorder(),
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              ),
              onPressed: onRoll,
              child: const Text('Roll', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A90E2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            children: [
              const Text(
                'Dice roller',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // — first row: coin, d6, d8
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dieColumn(
                    label: 'Coin',
                    icon: Icon(Icons.monetization_on,
                        size: 64, color: Colors.white),
                    onRoll: _rollCoin,
                  ),
                  _dieColumn(
                    label: 'd6',
                    icon: Icon(Icons.casino, size: 64, color: Colors.white),
                    onRoll: () => _rollStandard(6),
                  ),
                  _dieColumn(
                    label: 'd8',
                    icon: Icon(Icons.change_history,
                        size: 64, color: Colors.white),
                    onRoll: () => _rollStandard(8),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // — second row: d12, d20, custom‐icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dieColumn(
                    label: 'd12',
                    icon: Icon(Icons.casino, size: 64, color: Colors.white),
                    onRoll: () => _rollStandard(12),
                  ),
                  _dieColumn(
                    label: 'd20',
                    icon: Image.asset(
                      'assets/images/d20.jpg',
                      width: 64,
                      height: 64,
                    ),
                    onRoll: () => _rollStandard(20),
                  ),
                  // just label + icon
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Custom roll',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 12),
                        Image.asset(
                          'assets/images/d20.jpg',
                          width: 64,
                          height: 64,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // — custom input
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 140,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _customController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Number of faces',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                    ),
                    onPressed: _rollCustom,
                    child:
                    const Text('Roll', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // — back to home
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 40),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
