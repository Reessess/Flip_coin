import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CoinFlipApp());
}

class CoinFlipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoinFlipScreen(),
    );
  }
}

class CoinFlipScreen extends StatefulWidget {
  @override
  _CoinFlipScreenState createState() => _CoinFlipScreenState();
}

class _CoinFlipScreenState extends State<CoinFlipScreen> with SingleTickerProviderStateMixin {
  String _coinImage = 'assets/coin_heads.png';
  String _resultText = 'Heads!';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flipCoin() {
    _controller.reset();
    _controller.forward().then((_) {
      setState(() {
        bool isHeads = Random().nextBool();
        _coinImage = isHeads ? 'assets/coin_heads.png' : 'assets/coin_tails.png';
        _resultText = isHeads ? 'Heads!' : 'Tails!';
        print(_resultText); // Print result to terminal
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flip Coin App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_animation.value),
                  child: Image.asset(
                    _coinImage,
                    width: 150,
                    height: 150,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              _resultText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: flipCoin,
              child: Text('Flip Coin'),
            ),
          ],
        ),
      ),
    );
  }
}