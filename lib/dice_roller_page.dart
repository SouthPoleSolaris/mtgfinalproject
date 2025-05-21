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

  void _rollCoin() => _showResult('Coin', _rnd.nextBool() ? 'Heads' : 'Tails');
  void _rollStandard(int faces) =>
      _showResult('d$faces', (_rnd.nextInt(faces) + 1).toString());
  void _rollCustom() {
    final n = int.tryParse(_customController.text) ?? 0;
    if (n < 1) {
      _showResult('Custom', 'Invalid # of faces');
    } else {
      _showResult('d$n', (_rnd.nextInt(n) + 1).toString());
    }
  }

  Widget _dieColumn({
    required String label,
    required Widget icon,
    VoidCallback? onRoll,
  }) {
    return SizedBox(
      width: 140,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 16),
          icon,
          const SizedBox(height: 16),
          if (onRoll != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: onRoll,
              child: const Text('Roll'),
            ),
        ],
      ),
    );
  }

  Widget _customColumn() {
    return SizedBox(
      width: 140,
      child: Column(
        children: [
          // label pill
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Custom roll',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 16),

          // icon
          Image.asset('assets/d20.png', width: 100, height: 100),
          const SizedBox(height: 16),

          // widened custom input box
          Container(
            width: 180, // ← made it wider
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: TextField(
                controller: _customController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '# of faces',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // roll button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: _rollCustom,
            child: const Text('Roll'),
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
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text(
              'Dice roller',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // first row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dieColumn(
                  label: 'Coin',
                  icon: Icon(Icons.monetization_on,
                      size: 100, color: Colors.white),
                  onRoll: _rollCoin,
                ),
                _dieColumn(
                  label: 'd6',
                  icon: Image.asset('assets/d6.png',
                      width: 100, height: 100),
                  onRoll: () => _rollStandard(6),
                ),
                _dieColumn(
                  label: 'd8',
                  icon: Image.asset('assets/d8.png',
                      width: 100, height: 100),
                  onRoll: () => _rollStandard(8),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dieColumn(
                  label: 'd12',
                  icon: Image.asset('assets/d12.png',
                      width: 100, height: 100),
                  onRoll: () => _rollStandard(12),
                ),
                _dieColumn(
                  label: 'd20',
                  icon: Image.asset('assets/d20.png',
                      width: 100, height: 100),
                  onRoll: () => _rollStandard(20),
                ),
                _customColumn(),
              ],
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: const StadiumBorder(),
                  padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 48),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
