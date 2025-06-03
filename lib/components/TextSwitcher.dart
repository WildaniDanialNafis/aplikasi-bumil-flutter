import 'dart:async';
import 'package:flutter/material.dart';

class TextSwitcher extends StatefulWidget {
  final List<String> texts;
  final Duration duration;
  final TextStyle? textStyle;

  TextSwitcher({
    required this.texts,
    this.duration = const Duration(seconds: 5),
    this.textStyle,
  });

  @override
  _TextSwitcherState createState() => _TextSwitcherState();
}

class _TextSwitcherState extends State<TextSwitcher> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startSwitchingText();
  }

  void _startSwitchingText() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child:Column(
          key: ValueKey<int>(_currentIndex),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.texts[_currentIndex],
                style: widget.textStyle ?? TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
    );
  }
}