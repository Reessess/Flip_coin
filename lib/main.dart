import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoinFlip(),
    );
  }
}

class CoinFlip extends StatefulWidget {
  const CoinFlip({super.key});

  @override
  _CoinFlipState createState() => _CoinFlipState();
}

class _CoinFlipState extends State<CoinFlip> with SingleTickerProviderStateMixin {
  int coinSide = 0; // 0 = Heads, 1 = Tails
  late AnimationController _controller;
  late Animation<double> _animation;

  // Function to flip the coin
  void flipCoin() {
    _controller.reset();
    _controller.forward().then((_) {
      setState(() {
        coinSide = Random().nextInt(2); // Random number between 0 and 1
      });
    });

    // Print the result in the terminal
    if (coinSide == 0) {
      print("Heads!");
    } else {
      print("Tails!");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coin Flip")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated rotation of the coin
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_animation.value),
                  child: Image.asset(
                    coinSide == 0 ? 'assets/coin_heads.png' : 'assets/coin_tails.png',
                    width: 150,
                    height: 150,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Button to flip the coin
            ElevatedButton(
              onPressed: flipCoin,
              child: const Text("Flip Coin"),
            ),
          ],
        ),
      ),
    );
  }
}
